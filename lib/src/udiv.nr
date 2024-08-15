use dep::bignum::BigNum;
use dep::bignum::fields::U256::{U256Params, U256_Instance};
use dep::bignum::fields::U384::{U384_Params, U384_Instance};
use dep::bignum::fields::U4096::{U4096Params, U4096_Instance};
use dep::bignum::fields::U1024::{U1024Params, U1024_Instance};
use dep::bignum::fields::U2048::{U2048Params, U2048_Instance};
use dep::bignum::runtime_bignum::{BigNumParamsTrait as RuntimeBigNumParamsTrait, BigNumInstance};
use dep::bignum::BigNumParamsTrait;
use crate::params::N_ITERATIONS;

fn benchmark_udiv<let N: u64, Params>(
    x: Field,
    y: Field,
    instance: BigNumInstance<N, Params>
) where Params: RuntimeBigNumParamsTrait<N> + BigNumParamsTrait<N> {
    let mut a_bn: BigNum<N, Params> = instance.__derive_from_seed([x as u8]);
    let mut b_bn: BigNum<N, Params> = instance.__derive_from_seed([y as u8]);

    for _ in 0..N_ITERATIONS {
        let c_bn = a_bn.udiv(b_bn);

        a_bn = b_bn;
        b_bn = c_bn;
    }
}

pub fn benchmark_udiv_U256(x: Field, y: Field) {
    benchmark_udiv(x, y, U256_Instance)
}

pub fn benchmark_udiv_U384(x: Field, y: Field) {
    benchmark_udiv(x, y, U384_Instance)
}

pub fn benchmark_udiv_U4096(x: Field, y: Field) {
    benchmark_udiv(x, y, U4096_Instance)
}

pub fn benchmark_udiv_U1024(x: Field, y: Field) {
    benchmark_udiv(x, y, U1024_Instance)
}

pub fn benchmark_udiv_U2048(x: Field, y: Field) {
    benchmark_udiv(x, y, U2048_Instance)
}
