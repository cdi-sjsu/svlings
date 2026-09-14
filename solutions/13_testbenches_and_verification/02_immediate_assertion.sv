module immediate_assertion (
    input  logic [7:0] value,
    output logic [1:0] band
);

    always_comb begin
        if (value < 8'd20)
            band = 2'd0;
        else if (value < 8'd30)
            band = 2'd1;
        else
            band = 2'd2;

        assert (band <= 2'd2) else $error("band out of range: %0d", band);
    end

endmodule
