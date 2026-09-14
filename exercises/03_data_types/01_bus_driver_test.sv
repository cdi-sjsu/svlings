module tb;

    logic       enable;
    logic [7:0] data;
    logic [7:0] bus;

    bus_driver dut (.enable(enable), .data(data), .bus(bus));

    int errors = 0;

    task automatic check(logic [7:0] want, string what);
        if (bus !== want) begin
            errors++;
            $display("  FAIL: %s -> expected bus=%b, got %b", what, want, bus);
        end
    endtask

    initial begin
        enable = 1; data = 8'hA5; #1; check(8'hA5, "enabled, drives data");

        // Our simulator can't pass a Z value through a task argument,
        // so this one check is done directly instead of going through
        // the check() task above.
        enable = 0; data = 8'hFF; #1;
        if (bus !== 8'bz) begin
            errors++;
            $display("  FAIL: disabled, lets go (Z) -> expected bus=zzzzzzzz, got %b", bus);
        end

        enable = 1; data = 8'h00; #1; check(8'h00, "re-enabled, drives data again");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
