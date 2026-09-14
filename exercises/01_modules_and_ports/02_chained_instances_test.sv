module tb;

    logic in, out;

    chained_instances dut (
        .in  (in),
        .out (out)
    );

    int errors = 0;

    task automatic check(logic want, string what);
        if (out !== want) begin
            errors++;
            $display("  FAIL: %s -> expected out=%b, got %b", what, want, out);
        end
    endtask

    initial begin
        in = 0; #1; check(1'b0, "in=0");
        in = 1; #1; check(1'b1, "in=1");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
