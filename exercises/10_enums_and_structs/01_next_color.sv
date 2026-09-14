// A traffic light cycles RED -> GREEN -> YELLOW -> RED -> ... This
// module should report what color comes after the current one.

typedef enum logic [1:0] {
    RED,
    GREEN,
    YELLOW
} color_e;

module next_color (
    input  color_e current,
    output color_e next
);

    always_comb begin
        case (current)
            // TODO: fill in what comes after RED, and what comes after
            // GREEN. YELLOW -> RED is done for you as an example.
            YELLOW:  next = RED;
            default: next = RED;
        endcase
    end

endmodule
