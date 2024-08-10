use bench_lib::mult::benchmark_mult_U384;

fn main(a: Field, b: Field) {
    benchmark_mult_U384(a, b);
}
