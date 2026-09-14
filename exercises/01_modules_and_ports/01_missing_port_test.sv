module tb;

    logic a, b, y;

    missing_port dut (
        .a (a),
        .b (b),
        .y (y)
    );

    int errors = 0;

    task automatic check(logic want, string what);
        if (y !== want) begin
            errors++;
            $display("  FAIL: %s -> expected y=%b, got %b", what, want, y);
        end
    endtask

    initial begin
        a = 0; b = 0; #1; check(1'b0, "a=0 b=0");
        a = 0; b = 1; #1; check(1'b0, "a=0 b=1");
        a = 1; b = 1; #1; check(1'b0, "a=1 b=1");
        a = 1; b = 0; #1; check(1'b1, "a=1 b=0");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
