// A tiny 4-entry memory. Writes happen synchronously, on the clock edge,
// but only when "we" (write-enable) is high. Reading is combinational -
// "dout" always shows whatever is currently stored at "addr", live,
// already wired up for you below.

module simple_ram (
    input  logic       clk,
    input  logic       we,
    input  logic [1:0] addr,
    input  logic [7:0] din,
    output logic [7:0] dout
);

    logic [7:0] mem [0:3];

    always_ff @(posedge clk) begin
        // TODO: when "we" is high, store "din" into mem at "addr".
    end

    assign dout = mem[addr];

endmodule
