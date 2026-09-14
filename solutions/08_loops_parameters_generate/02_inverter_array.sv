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
            inverter u_inv (.a(in[g]), .y(out[g]));
        end
    endgenerate

endmodule
