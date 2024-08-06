mod mult;
mod add;

use dep::bignum::BigNum;
use dep::bignum::fields::U256::{U256Params, U256_Instance};
use dep::bignum::runtime_bignum::{BigNumParamsTrait as RuntimeBigNumParamsTrait, BigNumInstance};

use crate::mult::{benchmark_mult_U256, benchmark_mult_U384, benchmark_mult_U4096};
use crate::add::{benchmark_add_U256, benchmark_add_U384, benchmark_add_U4096};

fn main(a: Field, b: Field) {
    benchmark_mult_U4096(a, b);
}
