module inferred_latch (
    input  logic a,
    input  logic b,
    output logic y
);

    always_comb begin
        if (a && !b)
            y = 1'b1;
        else
            y = 1'b0;
    end

endmodule
