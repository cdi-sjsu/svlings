module counter4 (
    input  logic       clk,
    input  logic       rst,
    input  logic       enable,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (rst)
            count <= 4'd0;
        else if (enable)
            count <= count + 1;
    end

endmodule
