// Shifting every bit of a vector one place to the left is the same as
// doubling it - the same way multiplying by 10 in decimal just appends
// a zero. This should output "value" doubled when "double_it" is high,
// and unchanged otherwise.

module shift_left (
    input  logic [7:0] value,
    input  logic       double_it,
    output logic [7:0] result
);

    // TODO: when double_it is 1, output value shifted left by 1 bit.
    // Otherwise, output value unchanged. Use the ternary operator you
    // saw back in the data types section: cond ? a : b.
    assign result = value;

endmodule
