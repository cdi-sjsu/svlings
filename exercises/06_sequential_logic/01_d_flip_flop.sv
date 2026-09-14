// The D flip-flop is the smallest unit of memory in digital design: one
// bit, updated once per clock tick. On every rising edge of clk, it
// should copy "d" into "q" - unless "rst" is high, in which case it
// should force q back to 0 instead, no matter what d is.

module d_flip_flop (
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);

    always_ff @(posedge clk) begin
        // TODO: if rst is high, set q <= 0. Otherwise, set q <= d.
        // Remember: nonblocking assignment (<=) inside always_ff.
    end

endmodule
