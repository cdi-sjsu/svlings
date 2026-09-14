module simple_ram (
    input  logic       clk,
    input  logic       we,
    input  logic [1:0] addr,
    input  logic [7:0] din,
    output logic [7:0] dout
);

    logic [7:0] mem [0:3];

    always_ff @(posedge clk) begin
        if (we)
            mem[addr] <= din;
    end

    assign dout = mem[addr];

endmodule
