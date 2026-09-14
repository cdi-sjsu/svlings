typedef enum logic [1:0] {
    STATE_A,
    STATE_B,
    STATE_C
} state_e;

module two_process_fsm (
    input  logic  clk,
    input  logic  rst,
    input  logic  tick,
    output state_e state_out
);

    state_e state, state_next;

    always_ff @(posedge clk) begin
        if (rst)
            state <= STATE_A;
        else if (tick)
            state <= state_next;
    end

    always_comb begin
        case (state)
            STATE_A: state_next = STATE_B;
            STATE_B: state_next = STATE_C;
            STATE_C: state_next = STATE_A;
            default: state_next = STATE_A;
        endcase
    end

    assign state_out = state;

endmodule
