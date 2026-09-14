module tb;

    logic a, b, sel, y;

    mux2to1 dut (.a(a), .b(b), .sel(sel), .y(y));

    int errors = 0;

    task automatic check(logic want, string what);
        if (y !== want) begin
            errors++;
            $display("  FAIL: %s -> expected y=%b, got %b", what, want, y);
        end
    endtask

    initial begin
        a = 0; b = 1; sel = 0; #1; check(1'b0, "sel=0 picks a");
        a = 0; b = 1; sel = 1; #1; check(1'b1, "sel=1 picks b");
        a = 1; b = 0; sel = 0; #1; check(1'b1, "sel=0 picks a (again)");
        a = 1; b = 0; sel = 1; #1; check(1'b0, "sel=1 picks b (again)");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
