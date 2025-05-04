use itertools::Itertools;


#[allow(dead_code)]
pub fn combine_strings_recursive(strings: Vec<String>) -> String {
    match strings.len() {
        0 => String::new(),
        1 => strings[0].clone(),
        _ => {
            let combined: Vec<String> = strings.into_iter()
                .chunks(2)
                .into_iter()
                .map(|chunk| {
                    let collected: Vec<String> = chunk.collect();
                    match collected.len() {
                        2 => format!("(and {} {})", collected[0], collected[1]),
                        1 => collected[0].clone(),
                        _ => String::new(),
                    }
                })
                .collect();

            combine_strings_recursive(combined)
        }
    }
}
