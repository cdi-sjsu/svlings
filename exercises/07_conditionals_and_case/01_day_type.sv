// "day" is a number from 0 to 6 (Sunday through Saturday). This should
// report whether it's a weekend day - that's day 0 (Sunday) or day 6
// (Saturday).

module day_type (
    input  logic [2:0] day,
    output logic       is_weekend
);

    always_comb begin
        case (day)
            // TODO: match 3'd0 and 3'd6 (comma-separated in one branch)
            // and set is_weekend = 1'b1.
            default: is_weekend = 1'b0;
        endcase
    end

endmodule
