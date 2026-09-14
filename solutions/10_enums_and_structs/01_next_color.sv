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
            RED:     next = GREEN;
            GREEN:   next = YELLOW;
            YELLOW:  next = RED;
            default: next = RED;
        endcase
    end

endmodule
