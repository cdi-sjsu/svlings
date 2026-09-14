// Sorts "value" into one of three bands: under 20 is band 0, 20-29 is
// band 1, and 30 or above should be band 2.

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
            // TODO: 30 and above should be band 2.
            band = 2'd0;

        // TODO: write an assertion stating that "band" should never be
        // more than 2'd2:
        //
        //   assert (band <= 2'd2) else $error("band out of range: %0d", band);
        //
        // Given the branches above, this can never actually fire - it's
        // here so you practice the syntax on a real (if trivial)
        // invariant. svlings can't grade "did you write this" the way
        // it grades your band values, so this one's on the honor
        // system - but it's worth doing anyway, because the habit is
        // the whole point.
    end

endmodule
