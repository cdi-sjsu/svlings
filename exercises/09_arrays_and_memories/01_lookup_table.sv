// "mem" below is a small, fixed lookup table - four 8-bit numbers,
// already filled in. Given a 2-bit address, this should output whatever
// value is stored at that address.

module lookup_table (
    input  logic [1:0] addr,
    output logic [7:0] value
);

    logic [7:0] mem [0:3] = '{8'd10, 8'd20, 8'd30, 8'd40};

    always_comb begin
        // TODO: read the entry at "addr" out of "mem" into "value".
        value = 8'd0;
    end

endmodule
