module tb;

    logic door_open, key_in_ignition, alarm;

    car_alarm dut (
        .door_open       (door_open),
        .key_in_ignition (key_in_ignition),
        .alarm           (alarm)
    );

    int errors = 0;

    task automatic check(logic want, string what);
        if (alarm !== want) begin
            errors++;
            $display("  FAIL: %s -> expected alarm=%b, got %b", what, want, alarm);
        end
    endtask

    initial begin
        door_open = 0; key_in_ignition = 0; #1; check(1'b0, "door shut, no key");
        door_open = 0; key_in_ignition = 1; #1; check(1'b0, "door shut, key in");
        door_open = 1; key_in_ignition = 1; #1; check(1'b0, "door open, key in");
        door_open = 1; key_in_ignition = 0; #1; check(1'b1, "door open, no key");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
