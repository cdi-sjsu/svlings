// An 8-bit value is really just two 4-bit halves stuck together. Each
// half is called a "nibble." This module should take the input byte and
// swap its two nibbles: the top 4 bits and bottom 4 bits trade places.
//
//   in  = 8'b1111_0000
//   out = 8'b0000_1111
//
// You're given the two halves already split out for you below. Your job
// is to glue them back together in the opposite order using the
// concatenation operator, { , }.

module nibble_swap (
    input  logic [7:0] in,
    output logic [7:0] out
);

    logic [3:0] upper_nibble; // in[7:4]
    logic [3:0] lower_nibble; // in[3:0]

    assign upper_nibble = in[7:4];
    assign lower_nibble = in[3:0];

    // TODO: build "out" by concatenating the two nibbles with the
    // lower one first (on the left) and the upper one second (on the
    // right), so they end up swapped.
    assign out = 8'b0000_0000;

endmodule
