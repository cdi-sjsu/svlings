module tb;

    logic a, b, c, y;

    signal_order dut (.a(a), .b(b), .c(c), .y(y));

    int errors = 0;

    task automatic check(logic want, string what);
        if (y !== want) begin
            errors++;
            $display("  FAIL: %s -> expected y=%b, got %b", what, want, y);
        end
    endtask

    initial begin
        // y should be (a AND b) OR (NOT c)
        a = 0; b = 0; c = 0; #1; check(1'b1, "a=0 b=0 c=0: NOT c is 1");
        a = 0; b = 0; c = 1; #1; check(1'b0, "a=0 b=0 c=1: neither half is true");
        a = 1; b = 1; c = 1; #1; check(1'b1, "a=1 b=1 c=1: a AND b is 1");
        a = 1; b = 0; c = 1; #1; check(1'b0, "a=1 b=0 c=1: a AND b is 0");
        a = 1; b = 1; c = 0; #1; check(1'b1, "a=1 b=1 c=0: both halves true");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
