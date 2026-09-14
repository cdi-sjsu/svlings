// This should chime whenever the car is moving and the seatbelt isn't
// buckled. Verilator will refuse to build this one as-is, and it's
// refusing for a good reason - read the error it gives you carefully,
// it's naming the exact problem described in this section's README.

module seatbelt_chime (
    input  logic driving,
    input  logic seatbelt_on,
    output logic chime
);

    always_comb begin
        if (driving && !seatbelt_on)
            chime = 1'b1;
        // TODO: this if has no else, so there's a path through this
        // block where "chime" never gets assigned - that's the latch.
        // Add an else that sets chime = 1'b0.
    end

endmodule
