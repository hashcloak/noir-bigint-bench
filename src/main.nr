use dep::bigint::{BigNum, BNExpressionInput};
use dep::bigint::fields::bn254Fq::BNParams as BNParams;
use dep::bigint::test_params::{
  nonprime4000::Test4000NonPrimeParams,
  nonprime3000::Test3000NonPrimeParams,
  prime2048::Test2048PrimeParams,
  };
use dep::bigint::BigNumParamsTrait;

type TestMod4000 = BigNum<34, Test4000NonPrimeParams>;
type TestMod3000 = BigNum<26, Test3000NonPrimeParams>;
type TestMod2048 = BigNum<18, Test2048PrimeParams>;

fn main(a: Field, b: Field) {
  // Enter function to benchmark
  // run `nargo info` to get gatecount
  // ~3000 gates are added upfront because of rangecheck, see
  // https://hackmd.io/xyvJnW9iQyWda-IJK1_yDw?#When-to-use-Karatsuba-and-when-to-use-Schoolbook
    benchmark_multiplication_2048(a, b);
}

fn benchmark_multiplication<N, Params>(x: Field, y: Field, _: BigNum<N, Params>) where Params: BigNumParamsTrait<N> {
    let z = x + y;
    let a = z * z;
    let b = a * a;

    let mut lhs: BigNum<N, Params> = BigNum::__derive_from_seed([a as u8]);
    let mut rhs: BigNum<N, Params> = BigNum::__derive_from_seed([b as u8]);
        
    let mut lhs_expr = BNExpressionInput::new(lhs, false);
    let rhs_expr = BNExpressionInput::new(rhs, false);

    let out: BigNum<N, Params> = lhs_expr.value.__mulmod(rhs_expr.value);
    out.validate_in_range();
    let rem = BNExpressionInput::new(out, true);
    BigNum::evaluate_quadratic_expression([[lhs_expr]], [[rhs_expr]], [rem]);
}

fn benchmark_multiplication_4000(x: Field, y: Field) {
    let stub: TestMod4000 = BigNum::new();
    benchmark_multiplication(x, y, stub)

    // Multiplication 34 limbs
    // Schoolbook 6841
    // 1-level Karatsuba 6730
    // 2-level Karatsuba 6684 <- optimal
    // 3-level Karatsuba 6783
}

fn benchmark_multiplication_3000(x: Field, y: Field) {
    let stub: TestMod3000 = BigNum::new();
    benchmark_multiplication(x, y, stub)

    // Multiplication 26 limbs
    // Schoolbook 4996
    // 1-level Karatsuba 4924
    // 2-level Karatsuba 4909 <- optimal
    // 3-level Karatsuba 4998
}

fn benchmark_multiplication_2048(x: Field, y: Field) {
    let stub: TestMod2048 = BigNum::new();
    benchmark_multiplication(x, y, stub)

    // Multiplication 18 limbs
    // Schoolbook 6800
    // 1-level Karatsuba 6761 <- optimal
    // 2-level Karatsuba 6788
}
