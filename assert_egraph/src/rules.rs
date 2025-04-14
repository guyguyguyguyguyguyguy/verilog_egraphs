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
        vec![
            // AND rules
            rw!("and1"; "(and ?a ?b)" => "(and ?b ?a)"),
            rw!("and2"; "(and ?a (and ?b ?c))" => "(and (and ?a ?b) ?c)"),

            // OR rules
            rw!("or1"; "(or ?a ?b)" => "(or ?b ?a)"),
            rw!("or2"; "(or ?a (or ?b ?c))" => "(or (or ?a ?b) ?c)"),

            // Not rules
            rw!("not1"; "(not true)" => "false"),
            rw!("not2"; "(not false)" => "true"),
            rw!("not3"; "(not (not ?a))" => "?a"),
        ]
    }

    fn signed_comparison_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![
            rw!("geq1"; "(>= ?a ?a)" => "true"),
            rw!("leq1"; "(<= ?a ?a)" => "true"),
            rw!("gt1"; "(> ?a ?a)" => "false"),
            rw!("lt1"; "(< ?a ?a)" => "false"),
        ];

        // Greater than or equal
        rules.extend([
            rw!("geq2"; "(>= ?a ?b)" <=> "(or (> ?a ?b) (= ?a ?b))"),
            rw!("geq3"; "(>= ?a ?b)" <=> "(or (< ?b ?a) (= ?a ?b))"),
            rw!("geq4"; "(>= ?a ?b)" <=> "(not (< ?a ?b))"),
        ].concat());

        // Less than or equal
        rules.extend([
            rw!("leq2"; "(<= ?a ?b)" <=> "(or (< ?a ?b) (= ?a ?b))"),
            rw!("leq3"; "(<= ?a ?b)" <=> "(or (> ?b ?a) (= ?a ?b))"),
            rw!("leq4"; "(<= ?a ?b)" <=> "(not (> ?a ?b))"),
        ].concat());

        // Greater than
        rules.extend([
            rw!("gt2"; "(> ?a ?b)" <=> "(< ?b ?a)"),
            rw!("gt3"; "(> ?a ?b)" <=> "(<= ?b ?a)"),
            rw!("gt4"; "(> ?a ?b)" <=> "(>= ?a ?b)"),
        ].concat());

        // Less than
        rules.extend([
            rw!("lt2"; "(< ?a ?b)" <=> "(>= ?b ?a)"),
            rw!("lt3"; "(< ?a ?b)" <=> "(<= ?a ?b)"),
        ].concat());

        rules
    }

    fn unsigned_comparison_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![
            rw!("ugeq1"; "(>=u ?a ?a)" => "true"),
            rw!("uleq1"; "(<=u ?a ?a)" => "true"),
            rw!("ugt1"; "(>u ?a ?a)" => "false"),
            rw!("ult1"; "(<u ?a ?a)" => "false"),
        ];

        // Unsigned greater than or equal
        rules.extend([
            rw!("ugeq2"; "(>=u ?a ?b)" <=> "(or (>u ?a ?b) (= ?a ?b))"),
            rw!("ugeq3"; "(>=u ?a ?b)" <=> "(or (<u ?b ?a) (= ?a ?b))"),
            rw!("ugeq4"; "(>=u ?a ?b)" <=> "(not (<u ?a ?b))"),
        ].concat());

        // Unsigned less than or equal
        rules.extend([
            rw!("uleq2"; "(<=u ?a ?b)" <=> "(or (<u ?a ?b) (= ?a ?b))"),
            rw!("uleq3"; "(<=u ?a ?b)" <=> "(or (>u ?b ?a) (= ?a ?b))"),
            rw!("uleq4"; "(<=u ?a ?b)" <=> "(not (>u ?a ?b))"),
        ].concat());

        // Unsigned greater than
        rules.extend([
            rw!("ugt2"; "(>u ?a ?b)" <=> "(<u ?b ?a)"),
            rw!("ugt3"; "(>u ?a ?b)" <=> "(<=u ?b ?a)"),
            rw!("ugt4"; "(>u ?a ?b)" <=> "(>=u ?a ?b)"),
        ].concat());

        // Unsigned less than
        rules.extend([
            rw!("ult3"; "(<u ?a ?b)" <=> "(>= ?b ?a)"),
            rw!("ult4"; "(<u ?a ?b)" <=> "(<= ?a ?b)"),
        ].concat());

        rules
    }

    fn bitwise_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![
            rw!("bvand1"; "(bvand ?a ?b)" => "(bvand ?b ?a)"),
            rw!("bvand2"; "(bvand ?a (bvnot ?a))" => "0"),
            rw!("bvand3"; "(bvand ?a ?a)" => "?a"),
            rw!("bvand5"; "(bvand ?a 0)" => "0"),
            // rw!("bvand6"; "(bvand ?a -1)" => "?a"),

            rw!("bvor1"; "(bvor ?a ?b)" => "(bvor ?b ?a)"),
            rw!("bvor2"; "(bvor ?a ?a)" => "?a"),
            rw!("bvor3"; "(bvor ?a 0)" => "?a"),
            rw!("bvor5"; "(bvor (bvand ?a ?b) (bvand ?a (bvnot ?b)))" => "?a"),
            // rw!("bvor6"; "(bvor ?a (bvnot ?a))" => "-1"),

        ];

        // Bitwise AND
        rules.extend([
            rw!("bvand4"; "(bvand ?a (bvand ?b ?c))" <=> "(bvand (bvand ?a ?b) ?c)"), // Don't need this here as we have commutatitivty
        ].concat());

        // Bitwise OR
        rules.extend([
            // rw!("bvor4"; "(or ?a (bvneg ?a))" <=> "-1"),
            rw!("bvor4"; "(bvor ?a (bvor ?b ?c))" <=> "(bvor (bvor ?a ?b) ?c)"),  // Don't need this here as we have commutatitivty
        ].concat());

        // Bitwise Not
        rules.extend([
            rw!("bvnot1"; "(bvnot ?a)" <=> "(bvsub (bvneg ?a) 1)"),
        ].concat());

        rules
    }

    // Arithmetic operators
    fn arithmetic_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let mut rules = vec![
            rw!("bvadd1"; "(bvadd ?a ?b)" => "(bvadd ?b ?a)"),
            rw!("bvadd3"; "(bvadd ?a 0)" => "?a"),
            rw!("bvadd4"; "(bvadd ?a (bvneg ?a))" => "0"),
            rw!("bvadd5"; "(bvadd ?a (bvneg ?b))" => "(bvsub ?a ?b)"),

            rw!("bvmul1"; "(bvmul ?a ?b)" => "(bvmul ?b ?a)"),
            rw!("bvmul3"; "(bvmul ?a 0)" => "0"),

            rw!("bvsub1"; "(bvsub ?a ?a)" => "0"),
            rw!("bvsub2"; "(bvsub ?a (bvneg ?b))" => "(bvadd ?a ?b)"),
        ];

        // Addition
        rules.extend([
            rw!("bvadd2"; "(bvadd ?a (bvadd ?b ?c))" <=> "(bvadd (bvadd ?a ?b) ?c)"),  // Don't need this here as we have commutatitivty
        ].concat());

        // Multiplication
        rules.extend([
            rw!("bvmul2"; "(bvmul ?a (bvmul ?b ?c))" <=> "(bvmul (bvmul ?a ?b) ?c)"),  // Don't need this here as we have commutatitivty
        ].concat());

        // Substitution
        rules.extend([
            rw!("bvsub3"; "(bvsub ?a ?b)" <=> "(bvadd ?a (bvneg ?b))"),  // Don't need this here as we have commutatitivty
        ].concat());

        // Neg
        // rules.extend([
        // ].concat());

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
