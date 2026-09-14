module lookup_table (
    input  logic [1:0] addr,
    output logic [7:0] value
);

    logic [7:0] mem [0:3] = '{8'd10, 8'd20, 8'd30, 8'd40};

    always_comb begin
        value = mem[addr];
    end

endmodule
