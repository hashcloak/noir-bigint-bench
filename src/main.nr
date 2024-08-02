use dep::bigint::{BigNum, BNExpressionInput};
use dep::bigint::fields::bn254Fq::BNParams as BNParams;
use dep::bigint::test_params::{
    nonprime1000::Test1000NonPrimeParams, nonprime3000::Test3000NonPrimeParams,
    nonprime4000::Test4000NonPrimeParams, prime2048::Test2048PrimeParams,
    nonprime250::Test250NonPrimeParams, nonprime230::Test230NonPrimeParams,
    nonprime470::Test470NonPrimeParams, nonprime590::Test590NonPrimeParams,
    nonprime710::Test710NonPrimeParams, nonprime830::Test830NonPrimeParams,
    nonprime950::Test950NonPrimeParams, nonprime1070::Test1070NonPrimeParams,
    nonprime1190::Test1190NonPrimeParams, nonprime1310::Test1310NonPrimeParams,
    nonprime1435::Test1435NonPrimeParams, nonprime1555::Test1555NonPrimeParams,
    nonprime1675::Test1675NonPrimeParams, nonprime1790::Test1790NonPrimeParams,
    nonprime1915::Test1915NonPrimeParams, nonprime2035::Test2035NonPrimeParams,
    nonprime2155::Test2155NonPrimeParams
};
use dep::bigint::BigNumParamsTrait;

type TestMod230 = BigNum<2, Test230NonPrimeParams>;
type TestMod250 = BigNum<3, Test250NonPrimeParams>;
type TestMod470 = BigNum<4, Test470NonPrimeParams>;
type TestMod590 = BigNum<5, Test590NonPrimeParams>;
type TestMod710 = BigNum<6, Test710NonPrimeParams>;
type TestMod830 = BigNum<7, Test830NonPrimeParams>;
type TestMod950 = BigNum<8, Test950NonPrimeParams>;
type TestMod1000 = BigNum<9, Test1000NonPrimeParams>;
type TestMod1070 = BigNum<9, Test1070NonPrimeParams>;
type TestMod1190 = BigNum<10, Test1190NonPrimeParams>;
type TestMod1310 = BigNum<11, Test1310NonPrimeParams>;
type TestMod1435 = BigNum<12, Test1435NonPrimeParams>;
type TestMod1555 = BigNum<13, Test1555NonPrimeParams>;
type TestMod1675 = BigNum<14, Test1675NonPrimeParams>;
type TestMod1790 = BigNum<15, Test1790NonPrimeParams>;
type TestMod1915 = BigNum<16, Test1915NonPrimeParams>;
type TestMod2035 = BigNum<17, Test2035NonPrimeParams>;
type TestMod2155 = BigNum<18, Test2155NonPrimeParams>;
type TestMod2048 = BigNum<18, Test2048PrimeParams>;
type TestMod3000 = BigNum<26, Test3000NonPrimeParams>;
type TestMod4000 = BigNum<34, Test4000NonPrimeParams>;

fn main(a: Field, b: Field) {
    // Enter function to benchmark
    // run `nargo info` to get gatecount
    // ~3000 gates are added upfront because of rangecheck, see
    // https://hackmd.io/xyvJnW9iQyWda-IJK1_yDw?#When-to-use-Karatsuba-and-when-to-use-Schoolbook
    benchmark_multiplication_3000(a, b);
}

fn benchmark_multiplication<let N: u64, Params>(x: Field, y: Field, _: BigNum<N, Params>) where Params: BigNumParamsTrait<N> {
    let mut z = x + y;
    let a = z * z;
    let b = a * a;

    let mut lhs: BigNum<N, Params> = BigNum::__derive_from_seed([a as u8]);
    let mut rhs: BigNum<N, Params> = BigNum::__derive_from_seed([b as u8]);
    for _ in 0..100 {
        let mut lhs_expr = BNExpressionInput::new(lhs, false);
        let rhs_expr = BNExpressionInput::new(rhs, false);

        let out: BigNum<N, Params> = lhs_expr.value.__mulmod(rhs_expr.value);
        out.validate_in_range();
        let rem = BNExpressionInput::new(out, true);
        BigNum::evaluate_quadratic_expression([[lhs_expr]], [[rhs_expr]], [rem]);
    }
}

fn benchmark_multiplication_230(x: Field, y: Field) {
    let stub: TestMod230 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_250(x: Field, y: Field) {
    let stub: TestMod250 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_470(x: Field, y: Field) {
    let stub: TestMod470 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_590(x: Field, y: Field) {
    let stub: TestMod590 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_710(x: Field, y: Field) {
    let stub: TestMod710 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_830(x: Field, y: Field) {
    let stub: TestMod830 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_950(x: Field, y: Field) {
    let stub: TestMod950 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1070(x: Field, y: Field) {
    let stub: TestMod1070 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1190(x: Field, y: Field) {
    let stub: TestMod1190 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1310(x: Field, y: Field) {
    let stub: TestMod1310 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1435(x: Field, y: Field) {
    let stub: TestMod1435 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1555(x: Field, y: Field) {
    let stub: TestMod1555 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1675(x: Field, y: Field) {
    let stub: TestMod1675 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1790(x: Field, y: Field) {
    let stub: TestMod1790 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1915(x: Field, y: Field) {
    let stub: TestMod1915 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_2035(x: Field, y: Field) {
    let stub: TestMod2035 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_2155(x: Field, y: Field) {
    let stub: TestMod2155 = BigNum::new();
    benchmark_multiplication(x, y, stub)
}

fn benchmark_multiplication_1000(x: Field, y: Field) {
    let stub: TestMod1000 = BigNum::new();
    benchmark_multiplication(x, y, stub)
    // Multiplication 9 limbs
    // Schoolbook 4042 <- slightly better
    // 1-level Karatsuba 4044
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

fn benchmark_multiplication_4000(x: Field, y: Field) {
    let stub: TestMod4000 = BigNum::new();
    benchmark_multiplication(x, y, stub)
    // Multiplication 34 limbs
    // Schoolbook 6841
    // 1-level Karatsuba 6730
    // 2-level Karatsuba 6684 <- optimal
    // 3-level Karatsuba 6783
}

fn benchmark_multiplication_2048(x: Field, y: Field) {
    let stub: TestMod2048 = BigNum::new();
    benchmark_multiplication(x, y, stub)
    // Multiplication 18 limbs
    // Schoolbook 6800
    // 1-level Karatsuba 6761 <- optimal
    // 2-level Karatsuba 6788
}
