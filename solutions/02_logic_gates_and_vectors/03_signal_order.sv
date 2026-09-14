// The added line is shown at the top here deliberately - above the
// statements that use c_inverted - to make the point that position in
// the file has no effect on the circuit.

module signal_order (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic y
);

    logic both_ab;
    logic c_inverted;

    assign c_inverted = ~c;

    assign y       = both_ab | c_inverted;
    assign both_ab = a & b;

endmodule
