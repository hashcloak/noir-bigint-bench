#!/bin/bash

# Experiment to be executed.
experiment_name="schoolbook"

# Regex to extract the number of ACIR opcodes and circuit size from the bb
# command. 
acir_opcodes_regex="(?<=\"acir_opcodes\":\s)\d+"
circuit_size_regex="(?<=\"circuit_size\":\s)\d+"

# Some paths to files
target_file="./target/bigint_benchmarking.json"
code_content_file="scripts/code_content.txt"
main_file="src/main.nr"
results_file="results/results_${experiment_name}.csv"

declare -a limbs=(
    230
    250
    470
    590
    710
    830
    950
    1000
    1070
    1190
    1310
    1435
    1555
    1675
    1790
    1915
    2035
    2155
    2048
    3000
    4000
)

# Defines the header for the CSV file
echo "Bits,ACIR opcodes,Circuit size" > $results_file

for n_bits in "${limbs[@]}"; do
    # Replace the bits in the source code and write it into the main.nr
    echo "Executing experiment for $n_bits"
    replaced_code=$(sed "s/\${bits}/$n_bits/" $code_content_file)
    echo "$replaced_code" > $main_file 

    # Compile the file.
    nargo compile

    # Count the gates.
    result=$(bb gates -b $target_file)

    # Save result in provisional file
    acir_opcodes=$(echo "$result" | grep -oP "$acir_opcodes_regex")
    n_gates=$(echo "$result" | grep -oP "$circuit_size_regex")

    echo "ACIR OP: $acir_opcodes"

    # Save results in files.
    echo "$n_bits,$acir_opcodes,$n_gates" >> $results_file
done

echo "Experiment finished."