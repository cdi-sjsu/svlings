module tb;

    logic [7:0] temp_c;
    logic [1:0] fan_speed;

    temperature_to_fan dut (.temp_c(temp_c), .fan_speed(fan_speed));

    int errors = 0;

    task automatic check(logic [1:0] want, string what);
        if (fan_speed !== want) begin
            errors++;
            $display("  FAIL: %s -> expected fan_speed=%0d, got %0d", what, want, fan_speed);
        end
    endtask

    initial begin
        temp_c = 8'd10; #1; check(2'd0, "10C is low");
        temp_c = 8'd19; #1; check(2'd0, "19C is still low");
        temp_c = 8'd20; #1; check(2'd1, "20C is medium");
        temp_c = 8'd29; #1; check(2'd1, "29C is still medium");
        temp_c = 8'd30; #1; check(2'd2, "30C is high");
        temp_c = 8'd80; #1; check(2'd2, "80C is definitely high");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
