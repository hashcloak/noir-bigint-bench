#!/bin/bash

experiment_name="schoolbook"

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

for n_bits in "${limbs[@]}"; do
    # Replace the bits in the source code and write it into the main.nr
    echo $n_bits
    replaced_code=$(sed "s/\${bits}/$n_bits/" scripts/code_content.txt)
    echo "$replaced_code" > src/main.nr

    # Compile the file.
    nargo compile

    # Count the gates.
    result=$(bb gates -b ./target/bigint_benchmarking.json)

    # Save results in files.
    echo "$result" > ./results/result_${experiment_name}_${n_bits}.txt
done

echo "Experiment finished."