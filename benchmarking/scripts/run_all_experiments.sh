#!/bin/bash

# Script that calls the individual scripts to run all the benchmarks.

bash ./scripts/bench_gate_number.sh "$1"
bash ./scripts/bench_proving_time.sh  "$1"
bash ./scripts/bench_verification_time.sh "$1"
