// Picks a fan speed based on temperature: under 20 is low, 20-29 is
// medium, and 30 or above should be high.

module temperature_to_fan (
    input  logic [7:0] temp_c,
    output logic [1:0] fan_speed
);

    always_comb begin
        if (temp_c < 8'd20)
            fan_speed = 2'd0; // low
        else if (temp_c < 8'd30)
            fan_speed = 2'd1; // medium
        else
            // TODO: 30 and above should be high speed (2'd2).
            fan_speed = 2'd0;

        // A sanity check: fan_speed should never be more than 2. This
        // can't actually fail given the branches above, but this is
        // what the syntax for stating an invariant looks like.
        assert (fan_speed <= 2'd2) else $error("fan_speed out of range: %0d", fan_speed);
    end

endmodule
