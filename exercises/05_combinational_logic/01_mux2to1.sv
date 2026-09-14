// A multiplexer ("mux" for short) is a selector switch: given two inputs
// and a select line, it picks one of them to pass through. This one
// picks "b" when sel is 1, and "a" when sel is 0.
//
// You could write this with assign and the ternary operator (in fact you
// already have, back in earlier sections) - but this time, write it with
// an always_comb block and a plain if/else, which is how you'll express
// most real combinational logic from here on.

module mux2to1 (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);

    always_comb begin
        // TODO: if sel is 1, y should be b. Otherwise, y should be a.
        y = 1'b0;
    end

endmodule
