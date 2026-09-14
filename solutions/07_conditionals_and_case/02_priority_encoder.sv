module priority_encoder (
    input  logic [3:0] request,
    output logic [1:0] grant
);

    always_comb begin
        casez (request)
            4'b1???: grant = 2'd3;
            4'b01??: grant = 2'd2;
            4'b001?: grant = 2'd1;
            4'b0001: grant = 2'd0;
            default: grant = 2'd0;
        endcase
    end

endmodule
