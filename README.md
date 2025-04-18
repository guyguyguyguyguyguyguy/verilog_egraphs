The exectuable made from this code expects two command line inputs, in-file and out-file (defaulted to "../assertionOutput.out").

To build exectiable:
  1. Install rust/cargo
  2. Go in to assert_egraph
  3. Run cargo build --release
  4. Exectuable will be found in target/release/

Run executable as follows:
   ./target/release/assert_egraph -f in-file -o out-file
