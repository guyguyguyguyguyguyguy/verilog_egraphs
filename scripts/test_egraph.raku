sub MAIN(Str $output-folder = "tests/", Bool $generate-equivalents = True) {
    # Create the output directory if it doesn't exist
    mkdir $output-folder unless $output-folder.IO.d;
    
    # Group operators by their arity and type system
    my %operators = (
        boolean => {
            binary => ["=", "and", "or"],
            # unary  => ["not"]
        },
        bitvector => {
            binary => {
                "(_ BitVec 64)" => [
                    "bvand", "bvor", "bvxor", 
                    "bvadd", "bvsub", "bvmul", "bvshl", "bvlshr"
                ],
                "Bool" => [
                    "bvsge", "bvsle", "bvsgt", "bvslt",
                    "bvuge", "bvule", "bvugt", "bvult",
                ],
            # unary  => ["bvneg", "bvnot"]
            }
        }
    );
    
    # Process Boolean operators
    for %operators<boolean>.kv -> $arity, @ops {
        for @ops -> $op {
            my $outfile = $op eq "=" ?? 'eqq.sl' !! "$op.sl";
            my $path = $output-folder.IO.add($outfile);
            my $equiv-path = $output-folder.IO.add($op eq "=" ?? 'eqq.equiv' !! "$op.equiv");
            
            # Generate the test file
            my $content = generate-boolean-test($op, $arity);
            $path.spurt($content);
            
            # Generate equivalents if requested
            generate_equivs($equiv-path, $path) if $generate-equivalents;
        }
    }
    
    # Process BitVector operators
    for %operators<bitvector>.kv -> $arity, %return-type-d {
        for %return-type-d.kv -> $return-type, @ops {
            for @ops -> $op {
                my $path = $output-folder.IO.add("$op.sl");
                my $equiv-path = $output-folder.IO.add("$op.equiv");
                
                # Generate the test file
                my $content = generate-bitvector-test($op, $arity, $return-type);
                $path.spurt($content);
                
                # Generate equivalents if requested
                generate_equivs($equiv-path, $path) if $generate-equivalents;
            }
        }
    }
}

sub generate-boolean-test(Str $operator, Str $arity --> Str) {
    my $vars = $arity eq 'binary' ?? "(x Bool)(y Bool)" !! "(x Bool)";
    my $op-expr = $arity eq 'binary' ?? "($operator x y)" !! "($operator x)";
    
    return qq:to/END/;
    (set-logic UF)
    (declare-var x Bool)
    {$arity eq 'binary' ?? "(declare-var y Bool)" !! ""}
    (synth-fun f ($vars) Bool
        ; declare a list of nonterminal symbols
        ((Start Bool))
        ; define the grammar
        (
            ; rules for nonterminal symbol 1
            (Start Bool
                (x 
                {$arity eq 'binary' ?? "y" !! ""}
                (not Start)
                (= Start Start)
                (and Start Start)
                (or Start Start)
                )
            )
        )
    )

    (constraint (= (f {$arity eq 'binary' ?? "x y" !! "x"}) $op-expr))

    (check-synth)
    END
}

sub generate-bitvector-test(Str $operator, Str $arity, Str $return-type --> Str) {
    my $vars      = $arity eq 'binary' ?? "(x (_ BitVec 64))(y (_ BitVec 64))" !! "(x (_ BitVec 64))";
    my $op-expr   = $arity eq 'binary' ?? "($operator x y)" !! "($operator x)";
    my $func-args = $arity eq 'binary' ?? "x y" !! "x";

    my $nonterminals = $return-type eq 'Bool'
        ?? "((StartBool Bool) (Start (_ BitVec 64)))"
        !! "((Start (_ BitVec 64)) (StartBool Bool))";

    my $grammar = $return-type eq 'Bool'
        ?? start-bool() ~ "\n" ~ start-bitvec($arity)
        !! start-bitvec($arity) ~ "\n" ~ start-bool();

    return qq:to/END/;
    (set-logic BV)
    (declare-var x (_ BitVec 64))
    {$arity eq 'binary' ?? "(declare-var y (_ BitVec 64))" !! ""}
    (synth-fun f ($vars) $return-type
        ; declare a list of nonterminal symbols
        $nonterminals
        ; define the grammar
        (
            ; rules for nonterminal symbol 1
            $grammar
        )
    )

    (constraint (= (f $func-args) $op-expr))

    (check-synth)
    END
}


sub generate_equivs(IO::Path $equiv-file, IO::Path $sygus-file) {
    my $cvc5-path = '/home/guy/Downloads/cvc5-Linux-x86_64-static/bin/cvc5';
    say "Generating equivalents for {$sygus-file.basename} -> {$equiv-file.basename}";
    
    # Use Proc::Async instead of run for proper process control
    my $proc = Proc::Async.new(:r, $cvc5-path, '--sygus-stream', $sygus-file);
    
    my @output-lines;
    my $line-count = 0;
    my $max-lines = 100;
    my $completed = Promise.new;
    my $promise-kept = False;  # Flag to track Promise status
    
    my $buffer = '';
    $proc.stdout.tap(-> $chunk {
        $buffer ~= $chunk;
        
        while $buffer ~~ /(.+?) \n/ {
            my $line = $0.Str.trim;
            if $line {
                push @output-lines, "($line)";
                $line-count++;
                
                if $line-count >= $max-lines && !$promise-kept {
                    $promise-kept = True;
                    $proc.kill(SIGTERM);
                    $completed.keep(True);
                    last;
                }
            }
            
            $buffer = $buffer.substr($0.Str.chars + 1);
        }
    });
    
    # Handle errors if needed
    $proc.stderr.tap(-> $chunk {
        # Only show error if it's not the expected SIGTERM message
        if $chunk.trim && $chunk.trim !~~ /interrupted \s+ by \s+ SIGTERM/ {
            note "cvc5 error: $chunk";
        }
    });
    
    # Start the process
    my $process-promise = $proc.start;
    
    # Set up a timeout in case the process doesn't produce enough output
    my $timeout = Promise.in(30); # 30 seconds timeout
    
    # Wait for either completion, timeout, or process end
    try {
        await Promise.anyof($completed, $timeout, $process-promise);
    }
    
    # Check if we need to kill the process (timeout case)
    if $timeout.status == Kept && !$promise-kept {
        $proc.kill(SIGTERM);
        say "Process timed out after 30 seconds with $line-count equivalents";
    }
    
    # Write the collected equivalents to the output file (limit to max lines)
    @output-lines = @output-lines[0..$max-lines-1] if @output-lines.elems > $max-lines;
    
    if @output-lines {
        $equiv-file.spurt(@output-lines.join("\n"));
        say "✓ Added {@output-lines.elems} equivalents to {$equiv-file.basename}";
    } else {
        say "✗ No equivalents generated for {$sygus-file.basename}";
    }
}

sub start-bool() {
    return qq:to/END/;
        (StartBool Bool (
            (bvsge Start Start)
            (bvsle Start Start)
            (bvsgt Start Start)
            (bvslt Start Start)
            (bvuge Start Start)
            (bvule Start Start)
            (bvugt Start Start)
            (bvult Start Start)))
    END
}

sub start-bitvec($arity) {
    return qq:to/END/;
        (Start (_ BitVec 64)
            (x 
            {$arity eq 'binary' ?? "y" !! ""}
            (bvneg Start)
            (bvnot Start)
            (bvand Start Start)
            (bvor Start Start)
            (bvxor Start Start)
            (bvadd Start Start)
            (bvsub Start Start)
            (bvmul Start Start)))
    END
}