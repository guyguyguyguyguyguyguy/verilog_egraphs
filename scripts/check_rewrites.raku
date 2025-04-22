sub MAIN($input-file, $output-file = "output.smt2") {
    my $file = $input-file.IO;
    
    unless $file.e && $file.f {
        die "File '$input-file' does not exist or is not a regular file";
    }
    
    my $output = $output-file.IO.open(:w);
    my $match-count = 0;
    
    for $file.lines.kv -> $line-no, $line {
        if $line ~~ /^ \s* 'rw!' \s* '(' \s* '"' $<a>=( <-["]>+ ) '"' \s* ';' \s* '"' $<b>=( <-["]>+ ) '"' \s* '=>' \s* '"' $<c>=( <-["]>+ ) '"' / {
            $output = $output-file.IO.open(:w, :truncate);
            $match-count++;
            my $b-expr = ~$<b>;
            my $c-expr = ~$<c>;
            
            # Extract variables and remove question marks
            my @vars = unique-vars($b-expr, $c-expr);

            say "\nProcessing rule #$match-count on line {$line-no+1}: $b-expr => $c-expr";
            
            # Generate SMT-LIB content
            generate-smt-lib($output, @vars, $b-expr, $c-expr);
            $output.close;
            
            # Run cvc5 on the generated file
            # my $proc = Proc::Async.new('/home/guy/Downloads/cvc5-Linux-x86_64-static/bin/cvc5', $output-file);
            my $cvc5-path = '/home/guy/Downloads/cvc5-Linux-x86_64-static/bin/cvc5';
            my $proc = run $cvc5-path, $output-file, :out, :err;
            my $output-text = $proc.out.slurp(:close);
            my $error-text = $proc.err.slurp(:close);

            $output-text=$output-text.trim;
            if $output-text.chars == 0 {
                say "Warning: No output received from cvc5";
                say "Error output: $error-text" if $error-text.chars > 0;
            }
            if $output-text ne "unsat" {
                say "CVC5 output is: $output-text";
                $output = $output-file.IO.open(:a);
                $output.say: "(get-model)";

                my $cvc5-path = '/home/guy/Downloads/cvc5-Linux-x86_64-static/bin/cvc5';
                my $proc = run $cvc5-path, '--produce-models', $output-file, :out, :err;
                $output-text = $proc.out.slurp(:close);
                $output-text=$output-text.trim;

                $output-text.say;
                say "Found non-unsat result at match #$match-count! Stopping.";
                say "Final SMT-LIB file is at $output-file";
                return;
            }
        }
    }
    
    $output.close;
    say "Generated SMT-LIB file at $output-file";
}

# Extract unique variables from expressions and remove question marks
sub unique-vars($b-expr, $c-expr) {
    my @all-vars = ($b-expr ~ " " ~ $c-expr).comb(/\?\w+/)
                   .unique
                   .sort
                   .map(*.substr(1));  # Remove the ? prefix
    return @all-vars;
}

# Generate the SMT-LIB file content
# Determine variable types based on their context in the expression
sub determine-var-types($expr) {
    my %var-types;

    # Boolean operators
    my %bool-ops = map { $_ => "Bool" }, < = and or not >;

    # Match all binary expressions
    for $expr.match(:g, / '(' \s* (<[\w\d\-_]>+) \s+ (\?\w+) \s+ (\?\w+) \s* ')' /) -> $m {
        my $op = ~$m[0];
        my $lhs = ~$m[1];
        my $rhs = ~$m[2];

        my $type = %bool-ops{$op} // "(_ BitVec 64)";

        %var-types{$lhs.substr(1)} = $type;
        %var-types{$rhs.substr(1)} = $type;
    }

    # Also handle unary expressions like `(not ?x)`
    for $expr.match(:g, / '(' \s* (<[\w\d\-_]>+) \s+ (\?\w+) \s* ')' /) -> $m {
        my $op = ~$m[0];
        my $var = ~$m[1];
        my $type = %bool-ops{$op} // "(_ BitVec 64)";
        %var-types{$var.substr(1)} = $type;
    }

    # Ensure all vars seen are typed
    for $expr.comb(/\?\w+/).unique -> $var {
        my $var-name = $var.substr(1);
        %var-types{$var-name} //= "(_ BitVec 64)";
    }

    return %var-types;
}

# Extract the outermost function to determine return type
sub determine-return-type($expr, %var-types) {
    # Remove leading whitespace
    my $clean-expr = $expr.trim;
    
    if "Bool" eq any(%var-types.values) {
        return "Bool";
    }

    # Check for direct boolean values
    return "Bool" if $clean-expr eq "true" || $clean-expr eq "false";
    
    # Check if expression starts with a boolean operator
    if $clean-expr ~~ /^ \s* \( \s* (['=' | 'bvult' | 'bvslt' | 'bvugt' | 'bvsgt' | 'bvule' | 'bvsle' | 'bvuge' | 'bvsge' | 'and' | 'or' | 'not']) \s/ {
        return "Bool";
    }

    return "(_ BitVec 64)";
}

# Generate the SMT-LIB file content
sub generate-smt-lib($output, @vars, $b-expr, $c-expr) {
    # Create variable replacements
    my %replace = (
        |@vars.map({ "?$_" => $_ }),
        '0'  => '#b0' ~ '0' x 63,
        '-1' => '#b1' ~ '1' x 63,
        '1'  => '#b' ~ '0' x 63 ~ '1',
        '2'  => '#b' ~ '0' x 62 ~ '10',
    );
    
    # Apply replacements to expressions
    my $clean-b = replace-vars($b-expr, %replace);
    my $clean-c = replace-vars($c-expr, %replace);
    
    $output.say: "(set-logic ALL)";
    
    # Determine variable types based on context
    my %b-var-types = determine-var-types($b-expr);
    my %c-var-types = determine-var-types($c-expr);
    
    # Merge variable types, preferring Bool over BitVec if there's a conflict
    my %var-types;
    for @vars -> $var {
        if (%b-var-types{$var}:exists && %b-var-types{$var} eq "Bool") || 
        (%c-var-types{$var}:exists && %c-var-types{$var} eq "Bool") {
            %var-types{$var} = "Bool";
        } else {
            %var-types{$var} = "(_ BitVec 64)";
        }
    }

    # Output variable declarations with inferred types
    for @vars -> $var {
        $output.say: "(declare-fun $var () {%var-types{$var}})";
    }
    
    # Determine return types from outermost function
    my $b-return-type = determine-return-type($b-expr, %var-types);
    my $c-return-type = determine-return-type($c-expr, %var-types);
    
    # Output function definitions with parameter list
    my $params = @vars.map({ "($_ {%var-types{$_}})" }).join(" ");

    $output.say: "(define-fun f ($params) $b-return-type $clean-b)";
    $output.say: "(define-fun g ($params) $c-return-type $clean-c)";
    
    # Special case for assertion when return types differ
    my $args = @vars.join(" ");
    
    my $f-header = $args.chars > 0 ?? "(f $args)" !! "f";
    my $g-header = $args.chars > 0 ?? "(g $args)" !! "g";
    $output.say: "(assert (not (= $f-header $g-header)))";
    
    $output.say: "(check-sat)";
}

# Replace variables in expression
# Replace variables in expression
sub replace-vars($expr, %replacements) {
    my $result = $expr;
    
    # First handle the special numeric cases (-1 and 1) with a more targeted approach
    # Replace -1 first with a temporary marker
    $result = $result.subst(rx{ '-1' }, 'NEGATIVE_ONE_MARKER', :g);
    # Replace 1 (but not as part of other tokens)
    $result = $result.subst(rx{ << '1' >> }, 'ONE_MARKER', :g);

    $result = $result.subst(rx{ << '2' >> }, 'TWO_MARKER', :g);
    
    # Now handle variables and other replacements
    for %replacements.kv -> $from, $to {
        next if $from eq '-1' || $from eq '1'; # Skip these as we handled them specially
        $result = $result.subst($from, $to, :g);
    }
    
    # Finally, replace our markers with the actual binary representations
    $result = $result.subst('NEGATIVE_ONE_MARKER', %replacements{'-1'}, :g);
    $result = $result.subst('ONE_MARKER', %replacements{'1'}, :g);
    $result = $result.subst('TWO_MARKER', %replacements{'2'}, :g);
    # Handle 0 separately if needed
    if %replacements{'0'}:exists {
        $result = $result.subst(rx{ << '0' >> }, %replacements{'0'}, :g);
    }
    
    return $result;
}