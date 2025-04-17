mod utils;
mod rules;

use egg::*;
use std::fs;
use utils::parse_assertions;
use rules::RuleBuilder;

#[allow(unused_imports)]
use itertools::Itertools;


type E = EGraph<Grammar, GramAn>;

define_language! {
    enum Grammar {
        "=" = Eq([Id;2]),
        "and" = And([Id;2]),
        "or" = Or([Id;2]),
        ">=" = Geq([Id;2]),
        "<=" = Leq([Id;2]),
        ">" = Gt([Id;2]),
        "<" = Lt([Id;2]),
        ">=u" = GeqU([Id;2]),
        "<=u" = LeqU([Id;2]),
        ">u" = GtU([Id;2]),
        "<u" = LtU([Id;2]),
        "bvand" = BAnd([Id;2]),
        "bvor" = BOr([Id;2]),
        "bvadd" = Add([Id;2]),
        "bvsub" = Minus([Id;2]),
        "bvmul" = Mul([Id;2]),

        "not" = Not(Id),
        "bvneg" = Neg(Id),
        "bvnot" = BNot(Id),

        Bool(Symbol),
        BitVec(Symbol),
    }
}

#[derive(Default, Clone)]
struct GramAn;
impl Analysis<Grammar> for GramAn {
   type Data = bool;

    fn merge(&mut self, to: &mut Self::Data, from: Self::Data) -> DidMerge {
        if !*to && from {
            *to = true;
            return DidMerge(true, true);
        }

        DidMerge(true, false)
    }

    fn make(egraph: &mut E, enode: &Grammar) -> Self::Data {
        let _x = |i: &Id| egraph[*i].data;
        // match enode {
        //     _ => None
        // }
        false
    }
}


fn main() {
    let e = EGraph::new(GramAn);
    let mut r = Runner::default().with_egraph(e);

    match fs::read_to_string("../bv_test.out") {
        Ok(output) => {
            let assertions = parse_assertions(&mut output.as_str());
            for _a in assertions.unwrap() {
                match _a.parse() {
                    Ok(a) => {
                        let id = r.egraph.add_expr(&a);
                        r.egraph.set_analysis_data(id, true);
                    },
                    Err(e) => panic!("Assertion not supported by grammar with error:\n\t {e}"),
                }
            }
        },
        Err(e) => panic!("Could not read file with error:\n\t {e}"),
    }

    println!("Number of classes after rewrites: {}", &r.egraph.classes().filter(|c| c.data).count());
    println!("{}", r.egraph.classes().filter(|c| c.data).map(|c| r.egraph.id_to_expr(c.id)).join("\n"));

    r = r.run(&RuleBuilder::all_rules());
    r.print_report();
    println!("Number of classes after rewrites: {}", &r.egraph.classes().filter(|c| c.data).count());
    println!("{}", r.egraph.classes().filter(|c| c.data).map(|c| r.egraph.id_to_expr(c.id)).join("\n"));
}
