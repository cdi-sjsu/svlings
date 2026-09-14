// A full traffic light, built the proper FSM way this time: a state
// register (always_ff) plus a combinational next-state block
// (always_comb), instead of just computing "what comes next" as a
// standalone function of the current color.
//
// "tick" stands in for "enough time has passed to change color" - a real
// traffic light would derive this from a timer, but that's not the
// point of this exercise, so it's just an input here.

typedef enum logic [1:0] {
    RED,
    GREEN,
    YELLOW
} color_e;

module traffic_light_fsm (
    input  logic  clk,
    input  logic  rst,
    input  logic  tick,
    output color_e light
);

    color_e state, state_next;

    // Block 1: the state register. Don't touch this one - it's the same
    // shape every FSM's register uses.
    always_ff @(posedge clk) begin
        if (rst)
            state <= RED;
        else if (tick)
            state <= state_next;
    end

    // Block 2: next-state logic. TODO: fill this in - it's the exact
    // same transition table you already wrote in the enums section.
    always_comb begin
        case (state)
            default: state_next = RED;
        endcase
    end

    assign light = state;

endmodule
