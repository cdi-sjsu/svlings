// This should invert every bit of "in" independently, using WIDTH copies
// of the "inverter" module below - one per bit - wired up by a generate
// for loop, instead of one big `assign out = ~in;` line.
//
// It's a slightly silly way to build something this simple, but the
// point is the pattern: this is exactly how you'd stamp out WIDTH copies
// of something much more interesting, like an ALU slice or a memory
// bank.

module inverter (
    input  logic a,
    output logic y
);
    assign y = ~a;
endmodule

module inverter_array #(
    parameter WIDTH = 4
) (
    input  logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);

    genvar g;
    generate
        for (g = 0; g < WIDTH; g++) begin : gen_inv
            // TODO: instantiate "inverter" here, named "u_inv", with
            // .a(in[g]) and .y(out[g]).
        end
    endgenerate

endmodule
