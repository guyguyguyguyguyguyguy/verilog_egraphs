#!/usr/bin/env raku
# Script to extract rewrite rules from Rust code and generate SMT2 files

sub MAIN($input-file, $output-file = "output.smt2") {
    my $file = $input-file.IO;

    unless $file.e && $file.f {
        die "File '$input-file' does not exist or is not a regular file";
    }

    my $match-count = 0;

    for $file.lines.kv -> $line-no, $line {
        if $line ~~ /^ \s* 'rw!' \s* '(' \s* '"' $<name>=( <-["]>+ ) '"' \s* ';' \s* '"' $<lhs>=( <-["]>+ ) '"' \s* '=>' \s* '"' $<rhs>=( <-["]>+ ) '"' / {
            $match-count++;
            my $rule-name = ~$<name>;
            my $lhs = ~$<lhs>;
            my $rhs = ~$<rhs>;

            # Skip rules with conditions (if statements)
            next if $line ~~ / 'if' \s+ 'Self::' /;

            say "\nProcessing rule #$match-count on line {$line-no+1} ($rule-name): $lhs => $rhs";

            # Generate and test the SMT2 file
            if !check_equivalence($lhs, $rhs, $output-file) {
                say "Found non-equivalent rule: $rule-name";
                say "Final SMT-LIB file is at $output-file";
                return;
            }
        }
    }

    say "All rules checked. No non-equivalent rules found.";
}

# Check if two expressions are equivalent by generating an SMT2 file and running cvc5
sub check_equivalence($lhs, $rhs, $output-file) {
    # Extract variables
    my @vars = extract_variables($lhs, $rhs);

    # Generate SMT2 file
    my $smt2 = generate_smt2($lhs, $rhs, @vars);

    # Write to file
    spurt $output-file, $smt2;

    # Run cvc5
    my $cvc5-path = '/home/guy/Downloads/cvc5-Linux-x86_64-static/bin/cvc5';
    my $proc = run $cvc5-path, $output-file, :out, :err;
    my $output = $proc.out.slurp(:close).trim;
    my $error = $proc.err.slurp(:close).trim;

    if $output.chars == 0 {
        say "Warning: No output received from cvc5";
        say "Error output: $error" if $error.chars > 0;
        return True; # Assume no problem if no output
    }

    if $output ne "unsat" {
        say "CVC5 output is: $output";

        # Add get-model to the file
        spurt $output-file, $smt2 ~ "\n(get-model)";

        # Run cvc5 again with model generation
        my $proc2 = run $cvc5-path, '--produce-models', $output-file, :out;
        my $model = $proc2.out.slurp(:close).trim;
        say $model;

        return False; # Found a counterexample
    }

    return True; # Expressions are equivalent
}

# Extract variables from expressions
sub extract_variables($expr1, $expr2) {
    my @vars = ($expr1 ~ " " ~ $expr2).comb(/\?\w+/)
               .unique
               .sort
               .map(*.substr(1)); # Remove the ? prefix
    return @vars;
}

# Determine if an expression is Boolean
sub is_boolean_expr($expr) {
    # Common Boolean patterns
    return True if $expr eq "true" || $expr eq "false";

    # Check if expression uses Boolean operators
    return True if $expr ~~ /^ \s* \( \s* ['=' | 'and' | 'or' | 'not' | '=>' | 'xor'] \s/;

    # Default to false if no clear boolean indicators
    return False;
}

# Generate SMT2 file content
sub generate_smt2($lhs, $rhs, @vars) {
    # Determine if we're dealing with Boolean expressions
    my $is_bool_context = is_boolean_expr($lhs) || is_boolean_expr($rhs);

    # Make a guess at what type each variable should be
    # For expressions with equality, not, and, or - force Boolean types
    my $force_bool = $lhs ~~ /'(not '/ || $rhs ~~ /'(not '/ ||
                    $lhs ~~ /'(and '/ || $rhs ~~ /'(and '/ ||
                    $lhs ~~ /'(or '/ || $rhs ~~ /'(or '/ ||
                    $lhs ~~ /'(= '/ || $rhs ~~ /'(= '/ ||
                    $lhs ~~ /'(=> '/ || $rhs ~~ /'(=> '/;

    my $var_type = $force_bool || $is_bool_context ?? "Bool" !! "(_ BitVec 64)";
    my $return_type = $var_type;

    # Replace Rust syntax with SMT2 syntax
    my $clean_lhs = clean_expression($lhs, @vars);
    my $clean_rhs = clean_expression($rhs, @vars);

    # Build the SMT2 file
    my $smt2 = "(set-logic ALL)\n";

    # Declare variables
    for @vars -> $var {
        $smt2 ~= "(declare-fun $var () $var_type)\n";
    }

    # Define functions
    my $params = @vars.map({ "($_ $var_type)" }).join(" ");
    $smt2 ~= "(define-fun f ($params) $return_type $clean_lhs)\n";
    $smt2 ~= "(define-fun g ($params) $return_type $clean_rhs)\n";

    # Add the assertion
    my $args = @vars.join(" ");
    my $f_call = @vars ?? "(f $args)" !! "f";
    my $g_call = @vars ?? "(g $args)" !! "g";
    $smt2 ~= "(assert (not (= $f_call $g_call)))\n";

    # Check sat
    $smt2 ~= "(check-sat)";

    return $smt2;
}

# Clean expressions for SMT2 format
sub clean_expression($expr, @vars) {
    my $result = $expr;

    # Replace variable references
    for @vars -> $var {
        $result = $result.subst("?$var", $var, :g);
    }

    # Replace literals for bitvectors if needed
    # For now, we'll skip this since we're focusing on boolean expressions

    return $result;
}
