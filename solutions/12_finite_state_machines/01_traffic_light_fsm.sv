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

    always_ff @(posedge clk) begin
        if (rst)
            state <= RED;
        else if (tick)
            state <= state_next;
    end

    always_comb begin
        case (state)
            RED:     state_next = GREEN;
            GREEN:   state_next = YELLOW;
            YELLOW:  state_next = RED;
            default: state_next = RED;
        endcase
    end

    assign light = state;

endmodule
