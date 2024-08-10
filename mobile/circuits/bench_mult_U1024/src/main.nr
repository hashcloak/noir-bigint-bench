use bench_lib::mult::benchmark_mult_U1024;

fn main(a: Field, b: Field) {
    benchmark_mult_U1024(a, b);
}
