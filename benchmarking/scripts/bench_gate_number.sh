#!/bin/bash

# Script to test the arithmetic operations between BigNum types in the
# noir-bignum library.

# Experiment to be executed.
experiment_name="schoolbook"

# Some paths to files
target_file="./target/bigint_benchmarking.json"
code_content_file="scripts/code_content.txt"
main_file="src/main.nr"
results_file="results/results_gate_count_${experiment_name}.csv"

# Read the parameters to execute just the selected experiments
operations=()
while getopts "smardek" flags; do
    case $flags in
    s)
        echo "Experiments for additions will be executed."
        operations+=("add")
    ;;
    r)
        echo "Experiments for additions will be executed."
        operations+=("sub")
    ;;
    m)
        echo "Experiments for multiplications will be executed."
        operations+=("mult")
    ;;
    d)
        echo "Experiments for unsigned division will be executed."
        operations+=("udiv")
    ;;
    e)
        echo "Experiments for equality will be executed."
        operations+=("eq")
    ;;
    k)
        echo "Experiments for unsigned remainder will be executed."
        operations+=("umod")
    ;;
    a)
        echo "All the experiments will be executed."
        operations=("add" "mult" "sub" "udiv" "eq" "umod")
    ;;
    *)
        echo "Invalid argument."
    ;;
    esac
done

declare -a types=(
    "U256"
    "U384"
    "U1024"
    "U2048"
    "U4096"
)

mkdir -p "$(dirname "$results_file")"

# Defines the header for the CSV file
echo "Type,Operation,ACIR opcodes,Circuit size" > $results_file

for operation in "${operations[@]}"; do
    for type in "${types[@]}"; do
        echo "Executing experiment for $operation on $type."

        # Replace the type and the operation that will be tested in the source 
        # code and write it into the main.nr
        replaced_code=$(sed -e "s/\${type}/$type/" -e $"s/\${operation}/$operation/" $code_content_file)
        echo "$replaced_code" > $main_file 

        # Compile the file.
        nargo compile

        # Count the gates.
        result=$(bb gates -b $target_file)

        # Extract acir_opcodes and circuit_size using awk
        acir_opcodes=$(echo "$result" | awk -F: '/"acir_opcodes"/ {gsub(/[^0-9]/, "", $2); print $2}')
        circuit_size=$(echo "$result" | awk -F: '/"circuit_size"/ {gsub(/[^0-9]/, "", $2); print $2}')

        echo "EXPERIMENT: $operation, ACIR OP: $acir_opcodes, Circuit Size: $circuit_size"

        # Save results in files.
        echo "$type,$operation,$acir_opcodes,$circuit_size" >> $results_file
    done
done
echo "Experiment finished."
