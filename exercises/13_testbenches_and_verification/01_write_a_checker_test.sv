// This file holds the fixed, already-correct circuit for this exercise.
// Go back to 01_write_a_checker.sv - that's where the actual TODO is.
//
// (Yes, this is backwards from every other exercise, where the
// "_test.sv" file does the checking. See the comment at the top of
// 01_write_a_checker.sv for why.)

module abs_diff (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [3:0] diff
);

    assign diff = (a > b) ? (a - b) : (b - a);

endmodule
