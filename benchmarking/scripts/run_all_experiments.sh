#!/bin/bash

bash ./scripts/bench_gate_number.sh "$@"
bash ./scripts/bench_proving_time.sh  "$@"
bash ./scripts/bench_verification_time.sh "$@"
