use egg::{Rewrite, rewrite as rw};
use crate::{GramAn, Grammar};


pub struct RuleBuilder;

impl RuleBuilder {
    fn eq_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        vec![
            rw!("eq1"; "(= ?a ?b)" => "(= ?b ?a)"),
            rw!("eq2"; "(= ?a ?a)" => "true"),
        ]
    }

    fn logical_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![];

        // AND rules
        rules.extend([
            rw!("and1"; "(and ?a ?b)"          => "(and ?b ?a)"),
            rw!("and2"; "(and ?a (and ?b ?c))" => "(and (and ?a ?b) ?c)"),
        ]);

        // OR rules
        rules.extend([
            rw!("or1"; "(or ?a ?b)"         => "(or ?b ?a)"),
            rw!("or2"; "(or ?a (or ?b ?c))" => "(or (or ?a ?b) ?c)"),
        ]);

        // Not rules
        rules.extend([
            rw!("not1"; "(not true)"     => "false"),
            rw!("not2"; "(not false)"    => "true"),
            rw!("not3"; "(not (not ?a))" => "?a"),
        ]);

        rules
    }

    fn signed_comparison_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![];

        // Greater than or equal
        rules.extend([
            rw!("geq1"; "(>= ?a ?a)"               => "true"),
            rw!("geq2"; "(or (> ?a ?b) (= ?a ?b))" => "(>= ?a ?b)"),
            rw!("geq3"; "(or (< ?b ?a) (= ?a ?b))" => "(>= ?a ?b)"),
            rw!("geq4"; "(not (< ?a ?b))"          => "(>= ?a ?b)"),
        ]);

        // Less than or equal
        rules.extend([
            rw!("leq1"; "(<= ?a ?a)"               => "true"),
            rw!("leq2"; "(or (< ?a ?b) (= ?a ?b))" => "(<= ?a ?b)"),
            rw!("leq3"; "(or (> ?b ?a) (= ?a ?b))" => "(<= ?a ?b)"),
            rw!("leq4"; "(not (> ?a ?b))"          => "(<= ?a ?b)"),
        ]);

        // Greater than
        rules.extend([
            rw!("gt1"; "(> ?a ?a)"  => "false"),
            rw!("gt2"; "(> ?a ?b)"  => "(< ?b ?a)"),
            rw!("gt3"; "(<= ?b ?a)" => "(> ?a ?b)"),
            rw!("gt4"; "(>= ?a ?b)" => "(> ?a ?b)"),
        ]);

        // Less than
        rules.extend([
            rw!("lt1"; "(< ?a ?a)"  => "false"),
            rw!("lt2"; "(>= ?b ?a)" => "(< ?a ?b)"),
            rw!("lt3"; "(<= ?a ?b)" => "(< ?a ?b)"),
        ]);

        rules
    }

    fn unsigned_comparison_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![];

        // Unsigned greater than or equal
        rules.extend([
            rw!("ugeq1"; "(bvuge ?a ?a)"               => "true"),
            rw!("ugeq2"; "(or (bvugt ?a ?b) (= ?a ?b))" => "(bvuge ?a ?b)"),
            rw!("ugeq3"; "(or (bvult ?b ?a) (= ?a ?b))" => "(bvuge ?a ?b)"),
            rw!("ugeq4"; "(not (bvult ?a ?b))"          => "(bvuge ?a ?b)"),
        ]);

        // Unsigned less than or equal
        rules.extend([
            rw!("uleq1"; "(bvule ?a ?a)"               => "true"),
            rw!("uleq2"; "(or (bvult ?a ?b) (= ?a ?b))" => "(bvule ?a ?b)"),
            rw!("uleq3"; "(or (bvugt ?b ?a) (= ?a ?b))" => "(bvule ?a ?b)"),
            rw!("uleq4"; "(not (bvugt ?a ?b))"          => "(bvule ?a ?b)"),
        ]);

        // Unsigned greater than
        rules.extend([
            rw!("ugt1"; "(bvugt ?a ?a)"  => "false"),
            rw!("ugt2"; "(bvugt ?a ?b)"  => "(bvult ?b ?a)"),
            rw!("ugt3"; "(bvugt ?a ?b)"  => "(bvule ?b ?a)"),
            rw!("ugt4"; "(bvugt ?a ?b)"  => "(bvuge ?a ?b)"),
        ]);

        // Unsigned less than
        rules.extend([
            rw!("ult1"; "(bvult ?a ?a)"  => "false"),
            rw!("ult2"; "(bvuge ?b ?a)" => "(bvult ?a ?b)"),
            rw!("ult3"; "(bvule ?a ?b)" => "(bvult ?a ?b)"),
        ]);

        rules
    }

    fn bitwise_rules() -> Vec<Rewrite<Grammar, GramAn>> {
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
            rw!("bvor4"; "(or ?a (bvneg ?a))"                         => "-1"),
            rw!("bvor5"; "(bvor (bvand ?a ?b) (bvand ?a (bvnot ?b)))" => "?a"),
            rw!("bvor6"; "(bvor ?a (bvnot ?a))"                       => "-1"),
            rw!("bvor7"; "(bvor ?a (bvand ?a ?b))"                    => "?a"),
            rw!("bvor8"; "(bvor (bvand ?a ?b) (bvand ?a (bvneg ?b)))" => "?a"),
            rw!("bvor9"; "(bvor ?a (bvor ?b ?c))"                     => "(bvor (bvor ?a ?b) ?c)"),
            rw!("bvor10"; "(bvand (bvor ?a ?b) (bvor ?a ?c))" => "(bvor ?a (bvand ?b ?c))"),
        ]);

        // Bitwise XOR
        rules.extend([
            rw!("bvxor1"; "(bvxor ?a ?b)"             => "(bvxor ?b ?a)"),
            rw!("bvxor2"; "(bvxor ?a 0)"              => "?a"),
            rw!("bvxor3"; "(bvxor ?a ?a)"             => "0"),
            rw!("bvxor4"; "(bvxor ?a (bvxor ?b ?c))"  => "(bvxor (bvxor ?a ?b) ?c)"),
        ]);

        // Bitwise NOT
        rules.extend([
            rw!("bvnot1"; "(bvnot (bvnot ?a))"             => "?a"),
        ]);

        rules
    }


    // Arithmetic operators
    fn arithmetic_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![];

        // Addition
        rules.extend([
            rw!("bvadd1"; "(bvadd ?a ?b)"            => "(bvadd ?b ?a)"),
            rw!("bvadd2"; "(bvadd ?a 0)"             => "?a"),
            rw!("bvadd3"; "(bvadd ?a (bvneg ?a))"    => "0"),
            rw!("bvadd4"; "(bvadd ?a (bvneg ?b))"    => "(bvsub ?a ?b)"),
            rw!("bvadd5"; "(bvadd ?a (bvadd ?b ?c))" => "(bvadd (bvadd ?a ?b) ?c)"),
            rw!("bvadd6"; "(bvadd (bvand ?a ?b) (bvnot ?b))" => "(bvor ?a (bvnot ?b))"),
            rw!("bvadd7"; "(bvadd (bvand ?a ?b) (bvand ?a (bvnot ?b)))" => "?a"),
        ]);

        // Multiplication
        rules.extend([
            rw!("bvmul1"; "(bvmul ?a ?b)"            => "(bvmul ?b ?a)"),
            rw!("bvmul2"; "(bvmul ?a 0)"             => "0"),
            rw!("bvmul3"; "(bvmul ?a (bvmul ?b ?c))" => "(bvmul (bvmul ?a ?b) ?c)"),
        ]);

        // Substitution
        rules.extend([
            rw!("bvsub1"; "(bvsub ?a ?a)"         => "0"),
            rw!("bvsub2"; "(bvsub ?a (bvneg ?b))" => "(bvadd ?a ?b)"),
            rw!("bvsub3"; "(bvsub (bvneg ?a) 1)"  => "(bvnot ?a)"),
            rw!("bvsub4"; "(bvsub (bvor ?a ?b) ?b)"  => "(bvand (bvor ?a ?b) (bvnot ?b))"),
            rw!("bvsub6"; "(bvsub ?a ?b)"  => "(bvneg (bvsub ?b ?a))"),
            rw!("bvsub7"; "(bvsub ?a (bvadd ?a ?a))"  => "(bvneg ?a)"),
        ]);

        // Left shift
        rules.extend([
            rw!("bvneg1"; "(bvneg (bvneg ?a))"  => "?a"),
        ]);

        // Left shift
        rules.extend([
            rw!("bvshl1"; "(bvshl ?a 0)"             => "?a"),
            rw!("bvshl2"; "(bvshl ?a ?b)"            => "(bvmul ?a (bvshl 1 ?b))"),
            rw!("bvshl3"; "(bvshl 0 ?a)"             => "0"),
            rw!("bvshl4"; "(bvshl (bvand ?a ?b) ?c)" => "(bvand (bvshl ?a ?c) (bvshl ?b ?c))"),
        ]);

        // Right shift
        rules.extend([
            rw!("bvshr1"; "(bvshr ?a 0)"             => "?a"),
            rw!("bvshr2"; "(bvshr 0 ?a)"             => "0"),
            rw!("bvshr3"; "(bvshr (bvand ?a ?b) ?c)" => "(bvand (bvshr ?a ?c) (bvshr ?b ?c))"),
        ]);

        rules
    }

    // Collect all rules
    pub fn all_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let rule_sets = [
            Self::eq_rules(),
            Self::logical_rules(),
            Self::signed_comparison_rules(),
            Self::unsigned_comparison_rules(),
            Self::bitwise_rules(),
            Self::arithmetic_rules(),
        ];

        rule_sets.into_iter().flatten().collect()
    }
}
