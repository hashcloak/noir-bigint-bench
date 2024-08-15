use dep::bignum::BigNum;
use dep::bignum::fields::U256::{U256Params, U256_Instance};
use dep::bignum::runtime_bignum::{BigNumParamsTrait as RuntimeBigNumParamsTrait, BigNumInstance};

use lib::mult::{
    benchmark_mult_U256, benchmark_mult_U384, benchmark_mult_U1024, benchmark_mult_U2048,
    benchmark_mult_U4096
};
use lib::add::{benchmark_add_U256, benchmark_add_U384, benchmark_add_U1024, benchmark_add_U2048, benchmark_add_U4096};
use lib::sub::{benchmark_sub_U256, benchmark_sub_U384, benchmark_sub_U1024, benchmark_sub_U2048, benchmark_sub_U4096};
use lib::udiv::{
    benchmark_udiv_U256, benchmark_udiv_U384, benchmark_udiv_U1024, benchmark_udiv_U2048,
    benchmark_udiv_U4096
};
use lib::umod::{
    benchmark_umod_U256, benchmark_umod_U384, benchmark_umod_U1024, benchmark_umod_U2048,
    benchmark_umod_U4096
};
use lib::eq::{benchmark_eq_U256, benchmark_eq_U384, benchmark_eq_U1024, benchmark_eq_U2048, benchmark_eq_U4096};

fn main(a: Field, b: Field) {
    benchmark_add_U4096(a, b);
}
