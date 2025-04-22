sub MAIN($input-dir, $output-file = "egraph_completeness.md") {
    my @input = $input-dir.IO;
    my $output = $output-file.IO.open(:w, :truncate);

    for @input.pop.dir -> $file-io {
        my $file = $file-io.Str;


        my $egraph-path = '/home/guy/Documents/other/leiqi/assert_egraph/target/release/assert_egraph';
        my $proc = run $egraph-path, '-f', $file, :out, :err;
        my $output-text = $proc.out.slurp(:close);
        my $error-text = $proc.err.slurp(:close);

        $file.say;
        if $file ~~ /"$input-dir/" (.*) "."/ {
            $output.say: "For {~$0}";
        }
        $output.say: $output-text.join("\n\t");
    }
}