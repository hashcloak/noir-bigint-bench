#!/bin/bash

# Script that benchmarks noir-bignum arithmetic operation proving times.

experiment_name="schoolbook"

# Some paths to files
target_file="./target/bigint_benchmarking.json"
code_content_file="scripts/code_content.txt"
main_file="src/main.nr"
witness_name="witness"
witness_path="./target/$witness_name.gz"
proof_path="./target/proof"
path_results="./results/results_proving_time_${experiment_name}_$(date)".csv
params_content_file="scripts/params_content.txt"
params_file="../lib/src/params.nr"

echo "Type,Operation,Iterations,Prover,Avg. Time,Std. Dev." > "$path_results"

# Read the parameters to execute just the selected experiments
operations=()
while getopts "smardekn:" flags; do
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
    n)
        n_iterations="$OPTARG"
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

declare -a provers=(
    "prove"
    "prove_ultra_honk"
)

for prover in "${provers[@]}"; do
    for operation in "${operations[@]}"; do
        for type in "${types[@]}"; do
            echo "Executing experiment for $operation on $type."

            # Replace the type and the operation that will be tested in the source 
            # code and write it into the main.nr
            replaced_code=$(sed -e "s/\${type}/$type/" -e $"s/\${operation}/$operation/" $code_content_file)
            echo "$replaced_code" > $main_file 

            # Replace the number of iterations in the library parameter file
            replaced_params=$(sed -e "s/\${n_iterations}/$n_iterations/" $params_content_file)
            echo "$replaced_params" > $params_file

            # Create witness
            nargo execute $witness_name

            file_name_result="results/result_${experiment_name}_${operation}_${type}_${prover}.txt"

            # Measure time
            hyperfine -u millisecond "bb $prover -b $target_file -w $witness_path -o $proof_path" --export-asciidoc "$file_name_result"

            time_not_correct_format=$(sed "6q;d" "$file_name_result")
            time_concatenated=${time_not_correct_format:2}

            IFS=" ± " read -r -a parts <<< "$time_concatenated"
            echo "Size of array: ${#parts}"
            echo "$type,$operation,$n_iterations,$prover,${parts[0]},${parts[2]}" >> "$path_results"
        done
    done
done

rm -f results/*.txt

echo "Experiment finished."

