// A 4-bit counter: it counts up by one every clock edge, but only while
// "enable" is high, and it resets back to 0 whenever "rst" is high
// (reset takes priority over counting).

module counter4 (
    input  logic       clk,
    input  logic       rst,
    input  logic       enable,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (rst)
            count <= 4'd0;
        // TODO: otherwise, if enable is high, add 1 to count.
        // (if enable is low, count should just hold its value - since
        // that's already what happens when you don't assign it here,
        // you don't need an explicit branch for that case.)
    end

endmodule
