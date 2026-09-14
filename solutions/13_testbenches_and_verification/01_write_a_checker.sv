module tb;

    logic [3:0] a, b, diff;

    abs_diff dut (.a(a), .b(b), .diff(diff));

    int errors = 0;

    task automatic check(logic [3:0] want, string what);
        if (diff !== want) begin
            errors++;
            $display("  FAIL: %s -> expected diff=%0d, got %0d", what, want, diff);
        end
    endtask

    initial begin
        a = 4'd9; b = 4'd3; #1; check(4'd6, "9 and 3");
        a = 4'd3; b = 4'd9; #1; check(4'd6, "3 and 9, same distance either way");
        a = 4'd2; b = 4'd15; #1; check(4'd13, "2 and 15");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
