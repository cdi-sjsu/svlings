// This watches a stream of bits go by, one per clock edge, and raises
// "detected" whenever the two most recently seen bits were both 1
// (overlap is fine - "1110" should detect twice: once for bits 2-3, and
// again for bits 3-4... well, bit 4 isn't 1 there, bad example, but you
// get the idea: 1111 detects on every cycle from the second 1 onward).
//
// Three states are enough:
//   S0 - haven't seen a 1 yet (or just saw a 0)
//   S1 - the last bit we saw was a single 1
//   S2 - the last two bits we saw were both 1 (this is when we detect!)

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
            // TODO: from S1, a 1 moves to S2 (two in a row!), a 0 moves
            // back to S0.
            // TODO: from S2, a 1 stays at S2 (still two in a row, just
            // shifted by one), a 0 moves back to S0.
            default: state_next = S0;
        endcase
    end

    assign detected = (state == S2);

endmodule
