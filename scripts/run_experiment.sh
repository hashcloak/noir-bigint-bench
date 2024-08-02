#!/bin/bash

# Experiment to be executed.
experiment_name="schoolbook"

# Some paths to files
target_file="./target/bigint_benchmarking.json"
code_content_file="scripts/code_content.txt"
main_file="src/main.nr"
results_file="results/results_${experiment_name}.csv"

declare -a limbs=(
256
)

# Defines the header for the CSV file
echo "Bits,ACIR opcodes,Circuit size" > $results_file

for n_bits in "${limbs[@]}"; do
    # Replace the bits in the source code and write it into the main.nr
    echo "Executing experiment for $n_bits"
    # replaced_code=$(sed "s/\${bits}/$n_bits/" $code_content_file)
    # echo "$code_content_file" > $main_file 

    # Compile the file.
    nargo compile

    # Count the gates.
    result=$(bb gates -b $target_file)

    # Extract acir_opcodes and circuit_size using awk
    acir_opcodes=$(echo "$result" | awk -F: '/"acir_opcodes"/ {gsub(/[^0-9]/, "", $2); print $2}')
    circuit_size=$(echo "$result" | awk -F: '/"circuit_size"/ {gsub(/[^0-9]/, "", $2); print $2}')

    echo "ACIR OP: $acir_opcodes, Circuit Size: $circuit_size"

    # Save results in files.
    echo "$n_bits,$acir_opcodes,$circuit_size" >> $results_file
done

echo "Experiment finished."
