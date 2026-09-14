// A state register built the proper FSM way: a state register
// (always_ff) plus a combinational next-state block (always_comb),
// instead of just computing "what comes next" as a standalone function
// of the current state.
//
// "tick" stands in for "something happened that means it's time to
// move to the next state" - a real design would derive this from
// whatever event actually matters, but that's not the point of this
// exercise, so it's just an input here.

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

    // Block 1: the state register. Don't touch this one - it's the same
    // shape every FSM's register uses.
    always_ff @(posedge clk) begin
        if (rst)
            state <= STATE_A;
        else if (tick)
            state <= state_next;
    end

    // Block 2: next-state logic. TODO: fill this in - it's the exact
    // same transition table you already wrote in the enums section.
    always_comb begin
        case (state)
            default: state_next = STATE_A;
        endcase
    end

    assign state_out = state;

endmodule
