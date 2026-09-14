// One correct way to write it. `parallel_out <= (parallel_out << 1) |
// serial_in;` also works and is equally fine.

module shift_register (
    input  logic       clk,
    input  logic       rst,
    input  logic       serial_in,
    output logic [7:0] parallel_out
);

    always_ff @(posedge clk) begin
        if (rst)
            parallel_out <= 8'd0;
        else
            parallel_out <= {parallel_out[6:0], serial_in};
    end

endmodule
