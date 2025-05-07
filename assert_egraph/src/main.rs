mod parser;
mod rules;
mod utils;

#[allow(unused_imports)]
use std::{collections::HashSet, fs};
use std::io::prelude::*;
use std::time::Duration;
use std::error::Error;

use clap::Parser;
use egg::*;
use itertools::{Itertools, Either};

use parser::{parse_assertions, Assertion};
use rules::{RuleBuilder, E};

#[allow(unused_imports)]
use utils::combine_strings_recursive;

type Result<T> = std::result::Result<T, Box<dyn Error>>;

define_language! {
    enum Grammar {
        "=" = Eq([Id; 2]),
        "and" = And([Id; 2]),
        "or" = Or([Id; 2]),
        "xor" = Xor([Id; 2]),
        "=>" = Implies([Id;2]),
        "bvsge" = Geq([Id; 2]),
        "bvsle" = Leq([Id; 2]),
        "bvsgt" = Gt([Id; 2]),
        "bvslt" = Lt([Id; 2]),
        "bvuge" = GeqU([Id; 2]),
        "bvule" = LeqU([Id; 2]),
        "bvugt" = GtU([Id; 2]),
        "bvult" = LtU([Id; 2]),
        "bvand" = BAnd([Id; 2]),
        "bvor" = BOr([Id; 2]),
        "bvxor" = BxOr([Id; 2]),
        "bvadd" = Add([Id; 2]),
        "bvsub" = Minus([Id; 2]),
        "bvmul" = Mul([Id; 2]),
        "not" = Not(Id),
        "bvneg" = Neg(Id),
        "bvnot" = BNot(Id),
        "bvshl" = Bvshl([Id; 2]),
        "bvlshr" = Bvshr([Id; 2]),
        Bool(Symbol),
        BitVec(Symbol),
    }
}

#[derive(Default, Clone)]
struct GrammarAnalysis;

impl Analysis<Grammar> for GrammarAnalysis {
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
    /// Input file path
    #[arg(short, long, default_value="../SygusResult.sl")]
    file: String,
    
    /// Enable verbose output
    #[arg(short, long, default_value="assertionOutput.out")]
    output: String,

    /// EGraph rewrite timeout
    #[arg(short, long, default_value="30")]
    timeout: u64,
}

fn main() -> Result<()> {
    let args = Args::parse();
    
    let e = EGraph::new(GrammarAnalysis);
    let mut runner = Runner::default().with_egraph(e.clone());
    let mut runner_conj = Runner::default().with_egraph(e);
    
    let content = fs::read_to_string(&args.file)
        .map_err(|e| format!("Could not read file: {e}"))?;
    
    let assertions = parse_assertions(&mut content.as_str())
        .map_err(|_| "Could not parse file")?;
    
    let (parsed, _unparsed): (Vec<_>, Vec<_>) = assertions
        .into_iter()
        .partition_map(|a| match a {
            Assertion::Parsed(s) => Either::Left(s),
            Assertion::Unparsed(s) => Either::Right(s),
        });

    println!("parsed: {}, unparsed: {}", parsed.len(), _unparsed.len());
    let mut ids: Vec<(Id, String)> = vec![];

    for assertion in &parsed {
        match assertion.parse() {
            Ok(a) => {
                let id = runner.egraph.add_expr(&a);
                ids.push((id, a.to_string()));
                runner.egraph.set_analysis_data(id, true);
            },
            Err(e) => return Err(format!("Assertion not supported by grammar: {e}").into()),
        }
    }

    runner = runner
        .with_time_limit(Duration::new(args.timeout, 0))
        .with_node_limit(100_000)
        .run(&RuleBuilder::all_rules());

   println!("Unique assertions before: {}\nUnique asserttionas after: {}",
            ids.clone().into_iter().map(|(id, _)| id).collect::<HashSet<_>>().len(),
            runner.egraph
               .classes()
               .filter(|c| c.data)
               .count()
   );


    runner.print_report();

    // println!("{:?}", runner.egraph.dump());

    if let Some(id) = runner.egraph.lookup_expr(&"(xor II131 II130)".parse().unwrap()) {
        ids.iter().for_each(|(_id, a)| {
            let iid = runner.egraph.find(*_id);
            if id == iid {
                println!("{}", a);
            }
        });
    }

   //  let conjunc = combine_strings_recursive(parsed.clone());
   //  let id = runner_conj.egraph.add_expr(&conjunc.parse().unwrap());
   //  runner_conj.egraph.set_analysis_data(id, true);

   // runner_conj = runner_conj
   //     .with_time_limit(Duration::new(args.timeout, 0))
   //     .with_node_limit(100_000)
   //     .run(&RuleBuilder::all_rules());

   // let extractor = Extractor::new(&runner_conj.egraph, AstSize);
   // let (_, best) = extractor.find_best(id);
   // let rewritten = best.to_string();


   // println!("Before conjunction: {} characters\nAfter conjunction: {} characters\nAfter rewrite: {} characters",
   //          parsed.join("").chars().count(),
   //          conjunc.chars().count(),
   //          rewritten.chars().count()
   // );
   // runner_conj.print_report();

    let unique_assertions = runner.egraph
        .classes()
        .filter(|c| c.data)
        .map(|c| runner.egraph.id_to_expr(c.id))
        .join("\n");

    let mut file = fs::File::create(args.output)?;
    file.write_all(unique_assertions.as_bytes().as_ref())?;
    Ok(())
}
