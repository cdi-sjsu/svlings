module nibble_swap (
    input  logic [7:0] in,
    output logic [7:0] out
);

    logic [3:0] upper_nibble;
    logic [3:0] lower_nibble;

    assign upper_nibble = in[7:4];
    assign lower_nibble = in[3:0];

    assign out = {lower_nibble, upper_nibble};

endmodule
