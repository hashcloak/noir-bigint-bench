# Benchmarks for noir-bignum

This repository contains the scripts and source code used to benchmark the arithmetic operations in the noir-bignum repository. The benchmarks are for both computer and mobile executions of the proving system.

In the `mobile/` folder, you will find the source code needed to run the mobile benchmarks along with its [documentation](https://github.com/hashcloak/noir-bigint-bench/blob/main/mobile/README.md). Those benchmarks are implemented using the [Noir React Native starter project](https://github.com/madztheo/noir-react-native-starter).

In the `benchmarking/` folder, you will find the scripts used to benchmark the noir-bignum library on a computer. Inside the folder, you will find detailed [instructions](https://github.com/hashcloak/noir-bigint-bench/blob/main/benchmarking/README.md) on how to run the benchmark by yourself.

## Benchmark description

The purpose of the benchmark is to measure the performance of sum, subtraction, and multiplication of the [noir-bignum repository](https://github.com/noir-lang/noir-bignum). The computer benchmark measures three performance metrics: the number of gates of the circuit, the proving time, and the verification time. The mobile benchmarks measure just the proving time.

The benchmark considers five types from the noir-bignum library: `U256`, `U384`, `U1024`, `U2048`, and `U4096`. In just one program, we run $N$ arithmetic operations for each type between different pairs of instances. That means all the benchmark report results account for the $N$ operations. In the computer benchmark, the number of arithmetic operations to be run in a benchmark is adjusted by the user, and we will explain how to do this in the following sections. For the mobile benchmark, we defined $N = 100$.

We use the `hyperfine` tool for the timing reports in the computer benchmark. Hence, the timing results are the average running time of 10 executions of the corresponding command, namely proving or verification. On the other hand, for the mobile benchmarks, we report the time measured by the app. The timing results are reported for both UltraPlonk and UltraHonk proving systems.

## Execution example

If you want to run the computer benchmark by yourself, you can install the [requirements](https://github.com/hashcloak/noir-bigint-bench/blob/main/benchmarking/README.md#requirements) needed for the benchmarks. Then, the following command will give you the benchmark results for the multiplication operation using 50 operations per execution:

```
$ cd benchmarking/
$ bash scripts/run_all_experiments.sh -m -n 50
```
The results will be stored in the `benchmarking/results/` folder.

For more options to run the benchmark and more information about the results, please refer to the [detailed documentation](https://github.com/hashcloak/noir-bigint-bench/blob/main/mobile/README.md).

We refer the reader to the mobile documentation to run the mobile benchmark, given that the setup requires more steps.