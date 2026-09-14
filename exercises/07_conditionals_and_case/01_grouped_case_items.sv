// "sel" is a 3-bit value from 0 to 7. This should report "hit" whenever
// sel is exactly 0 or exactly 6 - two specific values, out of eight
// possible ones.

module grouped_case_items (
    input  logic [2:0] sel,
    output logic       hit
);

    always_comb begin
        case (sel)
            // TODO: match 3'd0 and 3'd6 (comma-separated in one branch)
            // and set hit = 1'b1.
            default: hit = 1'b0;
        endcase
    end

endmodule
