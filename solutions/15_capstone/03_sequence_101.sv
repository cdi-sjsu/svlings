// One correct way to write it. Any state encoding that produces the
// same behaviour is equally correct - what matters is the transition
// table, not the names.

typedef enum logic [1:0] {
    SAW_NOTHING,
    SAW_1,
    SAW_10,
    SAW_101
} match_state_e;

module sequence_101 (
    input  logic clk,
    input  logic rst,
    input  logic bit_in,
    output logic detected
);

    match_state_e state, state_next;

    always_ff @(posedge clk) begin
        if (rst)
            state <= SAW_NOTHING;
        else
            state <= state_next;
    end

    always_comb begin
        case (state)
            // A 1 starts a pattern; a 0 gets us nowhere.
            SAW_NOTHING: state_next = bit_in ? SAW_1 : SAW_NOTHING;

            // Another 1 means the previous one is wasted, but this new
            // one is still a valid start - so stay put rather than
            // going backwards.
            SAW_1:       state_next = bit_in ? SAW_1 : SAW_10;

            // A 1 completes 101. A 0 means we've seen 100, and none of
            // that is the start of anything, so back to the beginning.
            SAW_10:      state_next = bit_in ? SAW_101 : SAW_NOTHING;

            // Just detected. A 0 leaves us having seen ...1010, whose
            // last two bits are already two thirds of the next pattern -
            // this is what makes overlapping detection work. A 1 leaves
            // us with a fresh single 1.
            SAW_101:     state_next = bit_in ? SAW_1 : SAW_10;

            default:     state_next = SAW_NOTHING;
        endcase
    end

    assign detected = (state == SAW_101);

endmodule
