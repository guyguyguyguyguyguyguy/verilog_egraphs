mod utils;
mod rules;

use egg::*;
use std::fs::{File, read_to_string};
use std::io::prelude::*;
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
        ">=u" = GeqU([Id;2]),
        "<=u" = LeqU([Id;2]),
        ">u" = GtU([Id;2]),
        "<u" = LtU([Id;2]),
        "bvand" = BAnd([Id;2]),
        "bvor" = BOr([Id;2]),
        "bvxor" = BxOr([Id;2]),
        "bvadd" = Add([Id;2]),
        "bvsub" = Minus([Id;2]),
        "bvmul" = Mul([Id;2]),
        "bvshl" = Bvshl([Id;2]),
        "bvshr" = Bvshr([Id;2]),

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

    fn make(_egraph: &mut E, _enode: &Grammar) -> Self::Data {
        // let _x = |i: &Id| egraph[*i].data;
        false
    }
}

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    /// File of assertions to canonicalise
    #[arg(short, long, default_value="../sygusResult.out")]
    file: String,

    /// Output file
    #[arg(short, long, default_value="../assertionOutput.out")]
    output: String,
}


fn main() -> std::io::Result<()> {
    let args = Args::parse();
    let e = EGraph::new(GramAn);
    let mut r = Runner::default().with_egraph(e);

    match read_to_string(args.file) {
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

    r = r.with_node_limit(10_000).run(&RuleBuilder::all_rules());

    let unique_assertions = r.egraph.classes().filter(|c| c.data).map(|c| r.egraph.id_to_expr(c.id)).join("\n");
    let mut file = File::create(args.output)?;
    file.write_all(unique_assertions.as_bytes().as_ref())?;
    Ok(())
}
