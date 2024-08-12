#!/bin/bash

bash ./scripts/bench_gate_number.sh "$1"
bash ./scripts/bench_proving_time.sh  "$1"
bash ./scripts/bench_verification_time.sh "$1"
