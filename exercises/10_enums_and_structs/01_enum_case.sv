// "state" cycles through three named values in a fixed order:
// STATE_A -> STATE_B -> STATE_C -> STATE_A -> ... This should report
// what state comes after the current one.

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
            // TODO: fill in what comes after STATE_A, and what comes
            // after STATE_B. STATE_C -> STATE_A is done for you as an
            // example.
            STATE_C: next = STATE_A;
            default: next = STATE_A;
        endcase
    end

endmodule
