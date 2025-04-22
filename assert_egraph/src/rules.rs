use egg::{Rewrite, rewrite as rw};
use crate::{GrammarAnalysis, Grammar};

pub struct RuleBuilder;

impl RuleBuilder {
    fn eq_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        vec![
            rw!("eq0"; "(= ?a ?b)" => "(= ?b ?a)"),
            rw!("eq1"; "(= ?a ?a)" => "true"),
            rw!("eq2"; "(= ?a (not ?a))" => "false"),

            // NOTE: These are for bitvec, do we need to seperate equivalence for bitvec and for boolean?
            // rw!("eq2"; "(= ?a (bvnot ?a))" => "false"),
            // rw!("eq3"; "(= ?a (bvor ?a ?b))" => "false" if Self::is_not_equal("?a","?b")),
            // rw!("eq4"; "(= ?a (bvadd ?a ?a))" => "false" if Self::is_not_zero("?a")),

            // Add back in
            // rw!("eq5"; "(= (bvxor ?a ?b) ?c)" => "(= ?b (bvxor ?c ?a))"),
            // rw!("eq6"; "(= (bvxor ?a ?b) ?c)" => "(= ?a (bvxor ?c ?b))"),
            // rw!("eq7"; "(= ?a (bvxor ?b ?c))" => "(= (bvxor ?a ?c) ?b)"),
        ]
    }

    fn logical_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let mut rules = vec![];

        // AND rules
        rules.extend([
            rw!("and0"; "(and ?a ?b)"          => "(and ?b ?a)"),
            rw!("and1"; "(and ?a (and ?b ?c))" => "(and (and ?a ?b) ?c)"),
        ]);

        // OR rules
        rules.extend([
            rw!("or0"; "(or ?a ?b)"         => "(or ?b ?a)"),
            rw!("or1"; "(or ?a (or ?b ?c))" => "(or (or ?a ?b) ?c)"),
        ]);

        // Not rules
        rules.extend([
            rw!("not0"; "(not true)"     => "false"),
            rw!("not1"; "(not false)"    => "true"),
            rw!("not2"; "(not (not ?a))" => "?a"),
        ]);

        rules
    }

    fn signed_comparison_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let mut rules = vec![];

        // Greater than or equal
        rules.extend([
            rw!("geq1"; "(bvsge ?a ?a)"               => "true"),
        ]);

        // Less than or equal
        rules.extend([
            rw!("leq1"; "(bvsle ?a ?a)"               => "true"),
        ]);

        // Greater than
        rules.extend([
            rw!("gt1"; "(bvsgt ?a ?a)"  => "false"),
        ]);

        // Less than
        rules.extend([
            rw!("lt1"; "(bvslt ?a ?a)"  => "false"),
        ]);

        rules
    }

    fn unsigned_comparison_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let mut rules = vec![];

        // Unsigned greater than or equal
        rules.extend([
            rw!("ugeq1"; "(bvuge ?a ?a)"               => "true"),
            // rw!("ugeq2"; "(or (bvugt ?a ?b) (= ?a ?b))" => "(bvuge ?a ?b)"),
            // rw!("ugeq3"; "(or (bvult ?b ?a) (= ?a ?b))" => "(bvuge ?a ?b)"),
            // rw!("ugeq4"; "(not (bvult ?a ?b))"          => "(bvuge ?a ?b)"),
        ]);

        // Unsigned less than or equal
        rules.extend([
            rw!("uleq1"; "(bvule ?a ?a)"               => "true"),
            // rw!("uleq2"; "(or (bvult ?a ?b) (= ?a ?b))" => "(bvule ?a ?b)"),
            // rw!("uleq3"; "(or (bvugt ?b ?a) (= ?a ?b))" => "(bvule ?a ?b)"),
            // rw!("uleq4"; "(not (bvugt ?a ?b))"          => "(bvule ?a ?b)"),
        ]);

        // Unsigned greater than
        rules.extend([
            rw!("ugt1"; "(bvugt ?a ?a)"  => "false"),
        ]);

        // Unsigned less than
        rules.extend([
            rw!("ult1"; "(bvult ?a ?a)"  => "false"),
        ]);

        rules
    }

    fn bitwise_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let mut rules = vec![];

        // Bitwise AND
        rules.extend([
            rw!("bvand1"; "(bvand ?a ?b)"           => "(bvand ?b ?a)"),
            rw!("bvand2"; "(bvand ?a (bvnot ?a))"   => "0"),
            rw!("bvand3"; "(bvand ?a ?a)"           => "?a"),
            rw!("bvand4"; "(bvand ?a (bvand ?b ?c))" => "(bvand (bvand ?a ?b) ?c)"),
            rw!("bvand5"; "(bvand ?a 0)"            => "0"),
            rw!("bvand6"; "(bvand ?a -1)"           => "?a"),
            rw!("bvand7"; "(bvand ?a (bvor ?a ?b))" => "?a"),
            rw!("bvand8"; "(bvand ?a (bvor ?b ?c))" => "(bvor (bvand ?a ?b) (bvand ?a ?c))"),
            rw!("bvand9"; "(bvand ?a (bvor ?a ?b))" => "?a"),
            rw!("bvand10"; "(bvand ?a ?b)" => "(bvnot (bvor (bvnot ?a) (bvnot ?b)))"),
        ]);

        // Bitwise OR
        rules.extend([
            rw!("bvor1"; "(bvor ?a ?b)"                               => "(bvor ?b ?a)"),
            rw!("bvor2"; "(bvor ?a ?a)"                               => "?a"),
            rw!("bvor3"; "(bvor ?a 0)"                                => "?a"),
            rw!("bvor11"; "(bvor ?a -1)"                              => "-1"),
            rw!("bvor4"; "(bvor ?a (bvnot ?a))"                         => "-1"),
            rw!("bvor5"; "(bvor (bvand ?a ?b) (bvand ?a (bvnot ?b)))" => "?a"),
            rw!("bvor6"; "(bvor ?a (bvnot ?a))"                       => "-1"),
            rw!("bvor7"; "(bvor ?a (bvand ?a ?b))"                    => "?a"),
            rw!("bvor8"; "(bvor (bvand ?a ?b) (bvand ?a (bvnot ?b)))" => "?a"),
            rw!("bvor9"; "(bvor ?a (bvor ?b ?c))"                     => "(bvor (bvor ?a ?b) ?c)"),
            rw!("bvor10"; "(bvand (bvor ?a ?b) (bvor ?a ?c))"         => "(bvor ?a (bvand ?b ?c))"),
            rw!("bvor12"; "(bvor (bvxor ?a ?b) ?b)"                   => "(bvor ?a ?b)"),
        ]);

        // Bitwise XOR
        rules.extend([
            rw!("bvxor1"; "(bvxor ?a ?b)"             => "(bvxor ?b ?a)"),
            rw!("bvxor2"; "(bvxor ?a 0)"              => "?a"),
            rw!("bvxor3"; "(bvxor ?a ?a)"             => "0"),
            rw!("bvxor4"; "(bvxor ?a -1)"             => "(bvnot ?a)"),
            rw!("bvxor5"; "(bvxor ?a (bvxor ?b ?c))"  => "(bvxor (bvxor ?a ?b) ?c)"),
            rw!("bvxor6"; "(bvxor ?a (bvnot ?a))"     => "-1"),
            rw!("bvxor9"; "(bvxor (bvnot ?a) ?b)"     => "(bvnot (bvxor ?a ?b))"),
            rw!("bvxor10"; "(bvxor (bvnot ?a) ?b)"     => "(bvxor ?a (bvnot ?b))"),
            rw!("bvxor11"; "(bvxor (bvand ?a ?b) (bvand ?a (bvnot ?b)))"     => "?a"),
        ]);
        rules.extend([
            rw!("bvxor7"; "(bvxor ?a ?b)"     <=> "(bvor (bvand ?a (bvnot ?b)) (bvand (bvnot ?a) ?b)))"),
            rw!("bvxor8"; "(bvxor ?a ?b)"     <=> "(bvand (bvor ?a ?b) (bvnot (bvand ?a ?b)))"),
        ].concat());

        // Bitwise NOT
        rules.extend([
            rw!("bvnot1"; "(bvnot (bvnot ?a))"             => "?a"),
        ]);

        rules
    }


    // Arithmetic operators
    fn arithmetic_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let mut rules = vec![];

        // Addition
        rules.extend([
            rw!("bvadd1"; "(bvadd ?a ?b)"            => "(bvadd ?b ?a)"),
            rw!("bvadd2"; "(bvadd ?a 0)"             => "?a"),
            rw!("bvadd8"; "(bvadd ?a (bvnot ?a))"    => "-1"),
            rw!("bvadd3"; "(bvadd ?a (bvneg ?a))"    => "0"),
            rw!("bvadd4"; "(bvadd ?a (bvneg ?b))"    => "(bvsub ?a ?b)"),
            rw!("bvadd5"; "(bvadd ?a (bvadd ?b ?c))" => "(bvadd (bvadd ?a ?b) ?c)"),
            rw!("bvadd6"; "(bvadd (bvand ?a ?b) (bvnot ?b))" => "(bvor ?a (bvnot ?b))"),
            rw!("bvadd7"; "(bvadd (bvand ?a ?b) (bvand ?a (bvnot ?b)))" => "?a"),
            rw!("bvadd10"; "(bvadd (bvshl (bvand ?a ?b) 1) (bvxor ?a ?b))" => "(bvadd ?a ?b)"),
        ]);

        // Substitution
        rules.extend([
            rw!("bvsub8"; "(bvsub ?a 0)"         => "?a"),
            rw!("bvsub1"; "(bvsub ?a ?a)"         => "0"),
            rw!("bvsub9"; "(bvsub -1 ?a)"         => "(bvnot ?a)"),
            rw!("bvsub2"; "(bvsub ?a (bvneg ?b))" => "(bvadd ?a ?b)"),
            rw!("bvsub3"; "(bvsub (bvneg ?a) 1)"  => "(bvnot ?a)"),
            rw!("bvsub4"; "(bvsub (bvor ?a ?b) ?b)"  => "(bvand (bvor ?a ?b) (bvnot ?b))"),
            rw!("bvsub6"; "(bvsub ?a ?b)"  => "(bvneg (bvsub ?b ?a))"),
            rw!("bvsub7"; "(bvsub ?a (bvadd ?a ?a))"  => "(bvneg ?a)"),
        ]);

        // Neg shift
        rules.extend([
            rw!("bvneg1"; "(bvneg (bvneg ?a))"  => "?a"),
            rw!("bvneg2"; "(bvneg ?a)"  => "(bvsub 0 ?a)"),
        ]);

        // Multiplication
        rules.extend([
            rw!("bvmul1"; "(bvmul ?a ?b)"            => "(bvmul ?b ?a)"),
            rw!("bvmul2"; "(bvmul ?a 0)"             => "0"),
            rw!("bvmul3"; "(bvmul ?a 1)"             => "?a"),
            rw!("bvmul4"; "(bvmul ?a (bvmul ?b ?c))" => "(bvmul (bvmul ?a ?b) ?c)"),
            rw!("bvmul5"; "(bvmul ?a -1)"            => "(bvneg ?a)"),
            rw!("bvmul6"; "(bvadd (bvmul ?a ?b) ?a)" => "(bvmul ?a (bvadd ?b 1))"),
            rw!("bvmul7"; "(bvmul ?a -1)"             => "(bvneg ?a)"),
        ]);

        // Left shift
        rules.extend([
            rw!("bvshl1"; "(bvshl ?a 0)"             => "?a"),
            rw!("bvshl2"; "(bvshl ?a ?b)"            => "(bvmul ?a (bvshl 1 ?b))"),
            rw!("bvshl3"; "(bvshl 0 ?a)"             => "0"),
            rw!("bvshl4"; "(bvshl (bvor ?a ?b) ?c)"  => "(bvor (bvshl ?a ?c) (bvshl ?b ?c))"),
            rw!("bvshl5"; "(bvshl (bvor ?a ?b) ?c)"  => "(bvor (bvshl ?a ?c) (bvshl ?b ?c))"),
            rw!("bvshl6"; "(bvshl ?a 1)"             => "(bvadd ?a ?a)"),
            rw!("bvshl7"; "(bvshl ?a 1)"             => "(bvmul ?a 2)"),
        ]);

        // Right shift
        rules.extend([
            rw!("bvlshr1"; "(bvlshr ?a 0)"             => "?a"),
            rw!("bvlshr2"; "(bvlshr 0 ?a)"             => "0"),
            rw!("bvlshr3"; "(bvlshr (bvand ?a ?b) ?c)" => "(bvand (bvlshr ?a ?c) (bvlshr ?b ?c))"),
        ]);

        rules
    }

    pub fn other_bitvec() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let mut rules = vec![];

        // // Multiplexer
        // rules.extend([
        //     rw!("mux1"; "(mux 0 ?a ?b)"                                         => "?b"),
        //     rw!("mux2"; "(mux -1 ?a ?b)"                                        => "?a"),
        //     rw!("mux3"; "(mux ?a ?a (bvnot ?a))"                                => "-1"),
        //     rw!("mux4"; "(mux ?a (bvnot ?a) ?a)"                                => "0"),
        //     rw!("mux5"; "(mux ?a ?b (mux ?a ?c ?d))"                           => "(mux ?a ?b ?d)"),
        //     rw!("mux6"; "(mux ?a (mux ?a ?b ?c) ?d)"                          => "(mux ?a ?b ?d)"),
        //     rw!("mux7"; "(mux ?a ?b ?c)"                                        => "(bvor (bvand ?a ?b) (bvand (bvnot ?a) ?c))"),
        //     rw!("mux8"; "(bvor (bvand (bvnot ?a) ?b) (bvand ?a ?c))"            => "(mux ?a ?c ?b)"),
        // ]);

        // Misc
        rules.extend([
            rw!("mask"; "(bvand (bvxor ?a ?b) ?b)" => "(bvand (bvnot ?a) ?b)"),
            rw!("add_op"; "(bvadd (bvand ?a ?b) (bvor ?a ?b))" => "(bvadd ?a ?b)"),
            rw!("xor_op"; "(bvxor (bvand ?a ?b) (bvor ?a ?b))" => "(bvxor ?a ?b)"),
            rw!("or_op"; "(bvor (bvand ?a ?b) (bvor ?a ?b))" => "(bvor ?a ?b)"),
            rw!("and_op"; "(bvand (bvand ?a ?b) (bvor ?a ?b))" => "(bvand ?a ?b)"),
            rw!("sub_op"; "(bvsub (bvadd ?a ?b) (bvor ?a ?b))" => "(bvand ?a ?b)"),
        ]);
        rules.extend([
            rw!("dmorgan"; "(bvnot (bvand ?a ?b))" <=> "(bvor (bvnot ?a) (bvnot ?b))"),
        ].concat());


        // Special
        rules.extend([
            rw!("spec1"; "(bvand ?a (bvnot ?b))" => "(bvxor (bvand ?a ?b) ?a)"),
            rw!("spec2"; "(bvsub (bvadd ?a ?b) (bvxor ?a ?b))" => "(bvshl (bvand ?a ?b) 1)"),
            rw!("spec3"; "(bvsub (bvadd ?a ?b) (bvshl (bvand  ?a ?b) 1))" => "(bvxor ?a ?b)"),
        ]);

        rules
    }


    pub fn dist_bitvec() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        vec![
            rw!("add_neg"; "(bvneg (bvadd ?a ?b))" => "(bvsub (bvneg ?a) ?b)"),
            rw!("and_or"; "(bvand ?a (bvor ?b ?c))" => "(bvor (bvand ?a ?b) (bvand ?a ?c))"),
            rw!("or_and"; "(bvor (bvand ?a ?b) (bvand ?c ?b))" => "(bvand (bvor ?a ?c) ?b)"),
            rw!("and_xor"; "(bvand ?a (bvxor ?b ?c))" => "(bvxor (bvand ?a ?b) (bvand ?a ?c))"),
            rw!("xor_and"; "(bvxor (bvand ?a ?b) (bvand ?c ?b))" => "(bvand (bvxor ?a ?c) ?b)"),
            rw!("or_and2"; "(bvor ?a (bvand ?b ?c))" => "(bvand (bvor ?a ?b) (bvor ?a ?c))"),
            rw!("and_or2"; "(bvand (bvor ?a ?b) (bvor ?c ?b))" => "(bvor (bvand ?a ?c) ?b)"),
            rw!("mul_add"; "(bvmul ?a (bvadd ?b ?c))" => "(bvadd (bvmul ?a ?b) (bvmul ?a ?c))"),
            rw!("add_mul"; "(bvadd (bvmul ?a ?b) (bvmul ?c ?b))" => "(bvmul (bvadd ?a ?c) ?b)"),
            rw!("mul_sub"; "(bvmul ?a (bvsub ?b ?c))" => "(bvsub (bvmul ?a ?b) (bvmul ?a ?c))"),
            rw!("sub_mul"; "(bvsub (bvmul ?a ?b) (bvmul ?c ?b))" => "(bvmul (bvsub ?a ?c) ?b)"),

            rw!("shl_or"; "(bvshl (bvor ?a ?b) ?c)" => "(bvor (bvshl ?a ?c) (bvshl ?b ?c))"),
            rw!("or_shl"; "(bvor (bvshl ?a ?b) (bvshl ?c ?b))" => "(bvshl (bvor ?a ?c) ?b)"),
            rw!("shl_and"; "(bvshl (bvand ?a ?b) ?c)" => "(bvand (bvshl ?a ?c) (bvshl ?b ?c))"),
            rw!("and_shl"; "(bvand (bvshl ?a ?b) (bvshl ?c ?b))" => "(bvshl (bvand ?a ?c) ?b)"),
            rw!("shl_xor"; "(bvshl (bvxor ?a ?b) ?c)" => "(bvxor (bvshl ?a ?c) (bvshl ?b ?c))"),
            rw!("xor_shl"; "(bvxor (bvshl ?a ?b) (bvshl ?c ?b))" => "(bvshl (bvxor ?a ?c) ?b)"),
        ]
    }


    // fn is_not_equal(var: &'static str, var2: &'static str) -> impl Fn(&mut EGraph<Grammar, GrammarAnalysis>, Id, &Subst) -> bool {
    //     let var1 = var.parse().unwrap();
    //     let var2 = var2.parse().unwrap();
    //     move |_egraph, _, subst| subst[var1] != subst[var2]
    // }

    // fn is_not_zero(var: &'static str,) -> impl Fn(&mut EGraph<Grammar, GrammarAnalysis>, Id, &Subst) -> bool {
    //     let var = var.parse().unwrap();
    //     let zero = Grammar::BitVec(Symbol::from("0"));
    //     move |egraph, _, subst| !egraph[subst[var]].nodes.contains(&zero)
    // }


    // Collect all rules
    pub fn all_rules() -> Vec<Rewrite<Grammar, GrammarAnalysis>> {
        let rule_sets = [
            Self::eq_rules(),
            Self::logical_rules(),
            Self::signed_comparison_rules(),
            Self::unsigned_comparison_rules(),
            Self::bitwise_rules(),
            Self::arithmetic_rules(),
            Self::other_bitvec(),
            Self::dist_bitvec(),
        ];

        rule_sets.into_iter().flatten().collect()
    }
}
