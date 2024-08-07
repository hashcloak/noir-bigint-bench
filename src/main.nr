mod mult;
mod sub;
mod add;
mod udiv;
mod umod;
mod eq;

use dep::bignum::BigNum;
use dep::bignum::fields::U256::{U256Params, U256_Instance};
use dep::bignum::runtime_bignum::{BigNumParamsTrait as RuntimeBigNumParamsTrait, BigNumInstance};

use crate::mult::{benchmark_mult_U256, benchmark_mult_U384, benchmark_mult_U4096};
use crate::add::{benchmark_add_U256, benchmark_add_U384, benchmark_add_U4096};
use crate::sub::{benchmark_sub_U256, benchmark_sub_U384, benchmark_sub_U4096};
use crate::udiv::{benchmark_udiv_U256, benchmark_udiv_U384, benchmark_udiv_U4096};
use crate::umod::{benchmark_umod_U256, benchmark_umod_U384, benchmark_umod_U4096};
use crate::eq::{benchmark_eq_U256, benchmark_eq_U384, benchmark_eq_U4096};

fn main(a: Field, b: Field) {
    benchmark_umod_U4096(a, b);
}
