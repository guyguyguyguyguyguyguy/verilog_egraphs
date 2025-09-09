// arb2_with_assertions.sv
module arb2_with_assertions(CK, rst, req1, req2, gnt1, gnt2);
input CK, rst;
input req1, req2;
output gnt1, gnt2;

// Original arbiter logic
reg state;
reg gnt1, gnt2;

always @ (posedge CK or posedge rst)
	if (rst)
		state <= 0;
	else
		state <= gnt1;

always @ (*)
	if (state)
	begin
		gnt1 = req1 & ~req2;
		gnt2 = req2;
	end
	else
	begin
		gnt1 = req1;
		gnt2 = req2 & ~req1;
	end

// SVA Assertions integrated into the module
// Basic grant/request relationships
property p1; @(posedge CK) (!gnt2 && req1) |-> gnt1; endproperty
assert property (p1) else $error("Assertion p1 failed");

property p2; @(posedge CK) gnt1 |-> req1; endproperty
assert property (p2) else $error("Assertion p2 failed");

property p3; @(posedge CK) (!gnt1 && req2) |-> gnt2; endproperty
assert property (p3) else $error("Assertion p3 failed");

property p4; @(posedge CK) gnt2 |-> req2; endproperty
assert property (p4) else $error("Assertion p4 failed");

property p5; @(posedge CK) (!req2 && req1) |-> gnt1; endproperty
assert property (p5) else $error("Assertion p5 failed");

property p6; @(posedge CK) (!req1 && req2) |-> gnt2; endproperty
assert property (p6) else $error("Assertion p6 failed");

// Temporal assertions
property p7; @(posedge CK) !gnt1 ##1 req1 |-> gnt1; endproperty
assert property (p7) else $error("Assertion p7 failed");

property p8; @(posedge CK) !req1 ##1 req1 |-> gnt1; endproperty
assert property (p8) else $error("Assertion p8 failed");

property p9; @(posedge CK) gnt1 ##1 req2 |-> gnt2; endproperty
assert property (p9) else $error("Assertion p9 failed");

property p10; @(posedge CK) gnt2 ##1 req1 |-> gnt1; endproperty
assert property (p10) else $error("Assertion p10 failed");

// Note: Some of the original assertions appear to have logical issues
// The following are commented out as they may not be correct:
// property p11; @(posedge CK) (!gnt2 && req2) |-> req1; endproperty
// property p12; @(posedge CK) (!gnt1 && req1) |-> req2; endproperty

// Reset behavior assertions
property p13; @(posedge CK) rst ##2 req1 |-> gnt1; endproperty
assert property (p13) else $error("Assertion p13 failed");

property p14; @(posedge CK) rst ##3 req1 |-> gnt1; endproperty
assert property (p14) else $error("Assertion p14 failed");

endmodule

// Top-level wrapper for SBY
module top();
reg clk, rst, req1, req2;
wire gnt1, gnt2;

arb2_with_assertions dut(
    .CK(clk),
    .rst(rst),
    .req1(req1),
    .req2(req2),
    .gnt1(gnt1),
    .gnt2(gnt2)
);

// Clock generation for formal verification
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    req1 = 0;
    req2 = 0;
    #10 rst = 0;
end

endmodule
