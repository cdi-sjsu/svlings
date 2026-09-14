// This module reads an 8-bit two's-complement value (that's the standard
// way computers represent negative numbers) and reports whether it's
// negative.
//
// "value" is declared as a plain, unsigned 8-bit vector - SystemVerilog
// has no idea it's supposed to represent a signed number unless you tell
// it so at the point you use it.

module negative_check (
    input  logic [7:0] value,
    output logic       is_negative
);

    // TODO: use $signed(value) < 0 to treat "value" as a two's-complement
    // signed number for this one comparison, without changing how it's
    // declared.
    assign is_negative = 1'b0;

endmodule
