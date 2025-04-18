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
            rw!("and1"; "(and ?a ?b)" => "(and ?b ?a)"),
            rw!("and2"; "(and ?a (and ?b ?c))" => "(and (and ?a ?b) ?c)"),
        ]);

        // OR rules
        rules.extend([
            rw!("or1"; "(or ?a ?b)" => "(or ?b ?a)"),
            rw!("or2"; "(or ?a (or ?b ?c))" => "(or (or ?a ?b) ?c)"),
        ]);

        // Not rules
        rules.extend([
            rw!("not1"; "(not true)" => "false"),
            rw!("not2"; "(not false)" => "true"),
            rw!("not3"; "(not (not ?a))" => "?a"),
        ]);

        rules
    }


    // Collect all rules
    pub fn all_rules() -> Vec<Rewrite<Grammar, GramAn>> {
        let rule_sets = [
            Self::eq_rules(),
            Self::logical_rules(),
        ];

        rule_sets.into_iter().flatten().collect()
    }
}
