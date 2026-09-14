// "Popcount" (population count) is just the number of 1-bits in a
// value. There's no single operator for it, so we compute it by walking
// every bit and adding one to a running total whenever we see a 1.
//
// WIDTH is a parameter, meaning whoever instantiates this module chooses
// how wide "data" is - the loop below has to work for any WIDTH, not
// just 8, which is exactly why it loops instead of listing every bit by
// name.

module popcount #(
    parameter WIDTH = 8
) (
    input  logic [WIDTH-1:0] data,
    output logic [3:0]       count
);

    always_comb begin
        count = 4'd0;
        for (int i = 0; i < WIDTH; i++) begin
            // TODO: if bit i of data is set, add 1 to count.
        end
    end

endmodule
