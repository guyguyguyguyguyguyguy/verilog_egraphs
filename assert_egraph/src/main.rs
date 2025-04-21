mod utils;
mod rules;

use egg::*;
use std::fs;
use std::time::Duration;
use utils::parse_assertions;
use rules::RuleBuilder;
use clap::Parser;

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
        "bvuge" = GeqU([Id;2]),
        "bvule" = LeqU([Id;2]),
        "bvugt" = GtU([Id;2]),
        "bvult" = LtU([Id;2]),
        "bvand" = BAnd([Id;2]),
        "bvor" = BOr([Id;2]),
        "bvxor" = BxOr([Id;2]),
        "bvadd" = Add([Id;2]),
        "bvsub" = Minus([Id;2]),
        "bvmul" = Mul([Id;2]),

        "not" = Not(Id),
        "bvneg" = Neg(Id),
        "bvnot" = BNot(Id),

        // Other for rewriting, need to test if needed
        "bvshl" = Bvshl([Id;2]),
        "bvshr" = Bvshr([Id;2]),
        "mux" = Mux([Id;3]),

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
            return DidMerge(true, false);
        }
        DidMerge(false, false)
    }

    fn make(_egraph: &mut E, _enode: &Grammar) -> Self::Data {
        // let _x = |i: &Id| egraph[*i].data;
        false
    }
}

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    /// File of assertions to canonicalise
    #[arg(short, long, default_value="../tests/bvadd_test.out")]
    file: String,
}


fn main() {
    let args = Args::parse();
    let e = EGraph::new(GramAn);
    let mut r = Runner::default().with_egraph(e);

    match fs::read_to_string(args.file) {
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

    println!("Number of classes before rewrites: {}", &r.egraph.classes().filter(|c| c.data).count());

    r = r.with_time_limit(Duration::new(18, 0)).with_node_limit(100_000).run(&RuleBuilder::all_rules());
    r.print_report();
    println!("Number of classes after rewrites: {}", &r.egraph.classes().filter(|c| c.data).count());
    println!("{}", r.egraph.classes().filter(|c| c.data).map(|c| r.egraph.id_to_expr(c.id)).join("\n"));
}
