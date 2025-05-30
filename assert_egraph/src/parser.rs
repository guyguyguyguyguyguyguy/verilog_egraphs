use winnow::{
    ascii::{digit1, multispace0, till_line_ending},
    combinator::{alt, delimited, preceded, repeat,  seq},
    error::ContextError,
    prelude::*,
    token::take_while,
};


#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Term {
    Num(i32),
    Bool(bool),
    Var(String),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Expr {
    Term(Term),
    Operation {
        op: String,
        expr: Vec<Expr>,
    },
    Unparsed(String),
    Comment,
}

impl ToString for Term {
    fn to_string(&self) -> String {
        match self {
            Term::Num(n) => n.to_string(),
            Term::Bool(b) => b.to_string(),
            Term::Var(s) => s.clone(),
        }
    }
}

impl ToString for Expr {
    fn to_string(&self) -> String {
        match self {
            Expr::Term(term) => term.to_string(),
            Expr::Operation { op, expr } => {
                let args = expr
                    .iter()
                    .map(|e| e.to_string())
                    .collect::<Vec<String>>()
                    .join(" ");

                format!("({} {})", op, args)
            }
            Expr::Unparsed(s) => format!("Could not parse assertion {s}"),
            Expr::Comment =>  "".to_string(), 
        }
    }
}


fn ws<'a, O1, F>(inner: F) -> impl ModalParser<&'a str, O1, ContextError>
where
    F: ModalParser<&'a str, O1, ContextError>,
{
    delimited(multispace0, inner, multispace0)
}

fn s_exp<'a, O1, F>(inner: F) -> impl ModalParser<&'a str, O1, ContextError>
where
    F: ModalParser<&'a str, O1, ContextError>,
{
    delimited(
        ws('('),
        ws(inner),
        ws(')')
    )
}

fn parse_comment(i: &mut &'_ str) -> ModalResult<Expr> {
    preceded(ws('#'), till_line_ending)
    .map(|_| Expr::Comment)
    .parse_next(i)
}

pub fn parse_name(i: &mut &'_ str) -> ModalResult<String> {
    take_while(1.., |c: char| !(c.is_whitespace() || c == '(' || c == ')'))
        .map(|s: &str| s.to_string())
        .parse_next(i)
}

fn parse_term(i: &mut &'_ str) -> ModalResult<Term> {
    alt((
        alt(("true", "false")).try_map(|bool_str: &str| bool_str.parse::<bool>().map(Term::Bool)),
        digit1.try_map(|digit_str: &str| digit_str.parse::<i32>().map(Term::Num)),
        s_exp(preceded(ws('-'), ws(digit1))).try_map(|digit_str: &str| digit_str.parse::<i32>().map(|n| Term::Num(-n))),
        parse_name.map(Term::Var),
    ))
    .parse_next(i)
}


pub fn parse_expr(i: &mut &'_ str) -> ModalResult<Expr> {
    alt((
        ws(parse_term).map(Expr::Term),
        ws(s_exp(
            seq! {
                ws(parse_name),
                repeat(0.., ws(parse_expr)),
            }
            .map(|(op, exprs)| Expr::Operation { op, expr: exprs }),
        )),
    ))
    .parse_next(i)
}

fn parse_args(i: &mut &'_ str) -> ModalResult<Vec<Expr>> {
    repeat(1.., ws(parse_expr))
    .parse_next(i)
}

#[allow(dependency_on_unit_never_type_fallback)]
fn parse_define_fun(i: &mut &'_ str) -> ModalResult<Expr> {
    preceded(
        ws("define-fun"),
        seq! {
            ws(parse_name),
            ws(s_exp(repeat(0.., ws(s_exp(parse_args))))),
            ws(parse_expr),
            ws(parse_expr)
        }
    )
    .map(|(_, _, _, expr): (_, _, _, Expr)| {
        expr
    })
    .parse_next(i)
}

#[derive(Debug)]
pub enum Assertion {
    Parsed(String),
    Unparsed(String)
}

fn unparsed_define_fun(i: &mut &'_ str) -> ModalResult<Expr> {
    let _ = ws("(").parse_next(i)?;
    let _ = ws("define-fun").parse_next(i)?;
    
    let start = *i;
    let mut depth = 1; 
    
    let mut idx = 0;
    while idx < start.len() {
        let c = start[idx..].chars().next().unwrap();
        idx += c.len_utf8();
        
        if c == '(' {
            depth += 1;
        } else if c == ')' {
            depth -= 1;
            if depth == 0 {
                break;
            }
        }
    }
    
    let content = &start[..idx];
    *i = &start[idx..]; // This updates the input position
    
    Ok(Expr::Unparsed(format!("define-fun {}", content)))
}

// Then update parse_assertions to use this in the correct order
pub fn parse_assertions(input: &mut &'_ str) -> ModalResult<Vec<Assertion>, ContextError> {
    repeat(
        1..,
        alt((
            parse_comment,
            s_exp(alt((
                s_exp(parse_define_fun),
                unparsed_define_fun
            )))
        ))
    )
    .map(|asserts: Vec<Expr>| asserts
        .iter()
        .flat_map(|a| 
            match a {
                Expr::Term(_) | Expr::Operation{ .. } => Some(Assertion::Parsed(a.to_string())),
                Expr::Comment => None,
                Expr::Unparsed(s) => Some(Assertion::Unparsed(s.clone())),
            }
        )
        .collect()
    )
    .parse_next(input)
}