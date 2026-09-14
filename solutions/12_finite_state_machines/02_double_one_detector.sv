typedef enum logic [1:0] {
    S0,
    S1,
    S2
} seq_state_e;

module double_one_detector (
    input  logic clk,
    input  logic rst,
    input  logic bit_in,
    output logic detected
);

    seq_state_e state, state_next;

    always_ff @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= state_next;
    end

    always_comb begin
        case (state)
            S0: state_next = bit_in ? S1 : S0;
            S1: state_next = bit_in ? S2 : S0;
            S2: state_next = bit_in ? S2 : S0;
            default: state_next = S0;
        endcase
    end

    assign detected = (state == S2);

endmodule
