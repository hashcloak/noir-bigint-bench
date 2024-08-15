# Benchmark scripts

Benchmark resources and scripts for [noir-bignum](https://github.com/noir-lang/noir-bignum) arithmetic operations.

## Requirements

In the following list, we present the requirements to execute the benchmark scripts:
- `hyperfine` 1.12.0 or later: see installation instructions in the [main repository](https://github.com/sharkdp/hyperfine).
- `bb` v0.46.1.
- `nargo` v0.32.0.

## How to use

The benchmark scripts set is composed of three main scripts that can be executed separately:
- `scripts/bench_gate_number.sh`
- `scripts/bench_proving_time.sh`
- `scripts/bench_verification_time.sh`

To run the scripts, you can execute the following command in the terminal:
``` 
$ bash <script> <flags> -n <n_iterations>
```
Where `script` is one of the scripts listed above, and `n_iterations` is the number of arithmetic operations that will be executed in one run. For example, if you want to execute the benchmark that measures just the gate number, you should run:
```
$ bash scripts/bench_gate_number.sh <flags> -n 50
```

The flags are used to run the benchmark on specific operations. The available flags are:
- `-s`: run the benchmark for the addition operation.
- `-r`: run the benchmark for the subtraction operation.
- `-m`: run the benchmark for the multiplication operation.
- `-a`: run the benchmark for all the arithmetic operations available.

You can use one or several flags at the same time. For example, the flag `-sm` will run the benchmarks for both addition and multiplication operations. 

To run all the scripts to run the benchmark on all metrics, you can use the command
```
$ bash scripts/run_all_experiments.sh <flags> -n <n_iterations>
```
Where `<flags>` are the available flags that were explained above.

The results are stored in a separate CSV file in the `results/` folder, one CSV file for each type of benchmark.