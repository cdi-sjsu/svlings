// This should output 1 whenever a is high and b is low, and 0
// otherwise. Verilator will refuse to build this one as-is, and it's
// refusing for a good reason - read the error it gives you carefully,
// it's naming the exact problem described in this section's README.

module inferred_latch (
    input  logic a,
    input  logic b,
    output logic y
);

    always_comb begin
        if (a && !b)
            y = 1'b1;
        // TODO: this if has no else, so there's a path through this
        // block where "y" never gets assigned - that's the latch.
        // Add an else that sets y = 1'b0.
    end

endmodule
