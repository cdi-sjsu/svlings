module signed_comparison (
    input  logic [7:0] value,
    output logic       is_negative
);

    assign is_negative = $signed(value) < 0;

endmodule
