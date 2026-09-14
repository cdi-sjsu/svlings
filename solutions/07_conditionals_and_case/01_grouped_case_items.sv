module grouped_case_items (
    input  logic [2:0] sel,
    output logic       hit
);

    always_comb begin
        case (sel)
            3'd0, 3'd6: hit = 1'b1;
            default:    hit = 1'b0;
        endcase
    end

endmodule
