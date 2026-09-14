// Parity is a very old trick for catching corrupted data: alongside a
// byte, you send one extra bit that says whether the byte contains an
// odd or even number of 1s. If the receiver recomputes it and gets a
// different answer, something got flipped in transit.
//
// "Odd parity" is 1 exactly when the number of 1-bits in data is odd -
// which is exactly what reduction-XOR computes.

module parity_bit (
    input  logic [7:0] data,
    output logic       parity
);

    // TODO: fold "data" down to one bit with reduction-XOR.
    assign parity = 1'b0;

endmodule
