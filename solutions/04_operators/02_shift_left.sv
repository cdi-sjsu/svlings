module shift_left (
    input  logic [7:0] value,
    input  logic       double_it,
    output logic [7:0] result
);

    assign result = double_it ? (value << 1) : value;

endmodule
