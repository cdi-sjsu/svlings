// A (very simplified) volume control. "level" is the current volume.
// When "boost" is on, the output should be double the input level;
// otherwise it should just pass the level through unchanged.
//
// Doubling a number in binary is the same as shifting every bit one
// place to the left - the same way multiplying by 10 in decimal just
// appends a zero.

module volume_boost (
    input  logic [7:0] level,
    input  logic       boost,
    output logic [7:0] boosted_level
);

    // TODO: when boost is 1, output level shifted left by 1 bit.
    // Otherwise, output level unchanged. Use the ternary operator you
    // saw back in the data types section: cond ? a : b.
    assign boosted_level = level;

endmodule
