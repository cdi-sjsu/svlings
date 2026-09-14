// Heads up: this exercise flips the usual roles. Normally the file you
// edit describes a circuit, and the file you don't touch checks it.
// This time it's backwards: this file (which you DO edit) is a
// testbench, and 01_write_a_checker_test.sv (which you don't need to
// touch) holds a small, already-correct circuit called "abs_diff" -
// it outputs the absolute difference between two 4-bit numbers, e.g.
// abs_diff(9, 3) = 6.
//
// This file is still called "tb" like every other testbench you've
// seen, since that's the module name svlings looks for.

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

        // TODO: this expected value is wrong. Work out |2 - 15| for
        // yourself, and fix the "want" argument below to match.
        a = 4'd2; b = 4'd15; #1; check(4'd0, "2 and 15");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
