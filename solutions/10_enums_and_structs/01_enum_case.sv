typedef enum logic [1:0] {
    STATE_A,
    STATE_B,
    STATE_C
} state_e;

module enum_case (
    input  state_e current,
    output state_e next
);

    always_comb begin
        case (current)
            STATE_A: next = STATE_B;
            STATE_B: next = STATE_C;
            STATE_C: next = STATE_A;
            default: next = STATE_A;
        endcase
    end

endmodule
