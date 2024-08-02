use dep::bignum::BigNum;
use dep::bignum::fields::U256::{U256Params, U256_Instance};
use dep::bignum::runtime_bignum::{
  BigNumParamsTrait as RuntimeBigNumParamsTrait,
  BigNumInstance
};


type TestU256 = BigNum<3, U256Params>;

fn main(a: Field, b: Field) {
    // Enter function to benchmark
    // run `nargo info` to get gatecount
    // ~3000 gates are added upfront because of rangecheck, see
    // https://hackmd.io/xyvJnW9iQyWda-IJK1_yDw?#When-to-use-Karatsuba-and-when-to-use-Schoolbook
    benchmark_multiplication_U256(a, b);
}

fn benchmark_multiplication<let N: u64, Params>(x: Field, y: Field, instance: BigNumInstance<N, Params>) where Params: RuntimeBigNumParamsTrait<N> {
    let mut a_bn: BigNum<N, Params> = instance.__derive_from_seed([x as u8]);
    let mut b_bn: BigNum<N, Params> = instance.__derive_from_seed([y as u8]);

    for _ in 0..100 {
        let c_bn = instance.__mul(a_bn, b_bn);
        instance.evaluate_quadratic_expression([[a_bn]], [[false]], [[b_bn]], [[false]], [c_bn], [true]);

        a_bn = b_bn;
        b_bn = c_bn;
    }
}

fn benchmark_multiplication_U256(x: Field, y: Field) {
    benchmark_multiplication(x, y, U256_Instance)
}
