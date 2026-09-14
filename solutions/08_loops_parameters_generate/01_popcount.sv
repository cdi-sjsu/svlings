module popcount #(
    parameter WIDTH = 8
) (
    input  logic [WIDTH-1:0] data,
    output logic [3:0]       count
);

    always_comb begin
        count = 4'd0;
        for (int i = 0; i < WIDTH; i++) begin
            if (data[i])
                count = count + 1;
        end
    end

endmodule
