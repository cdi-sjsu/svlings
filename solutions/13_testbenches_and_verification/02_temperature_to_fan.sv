module temperature_to_fan (
    input  logic [7:0] temp_c,
    output logic [1:0] fan_speed
);

    always_comb begin
        if (temp_c < 8'd20)
            fan_speed = 2'd0;
        else if (temp_c < 8'd30)
            fan_speed = 2'd1;
        else
            fan_speed = 2'd2;

        assert (fan_speed <= 2'd2) else $error("fan_speed out of range: %0d", fan_speed);
    end

endmodule
