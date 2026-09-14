module day_type (
    input  logic [2:0] day,
    output logic       is_weekend
);

    always_comb begin
        case (day)
            3'd0, 3'd6: is_weekend = 1'b1;
            default:    is_weekend = 1'b0;
        endcase
    end

endmodule
