module tb;

    logic a, b, sum, carry;

    half_adder dut (.a(a), .b(b), .sum(sum), .carry(carry));

    int errors = 0;

    task automatic check(logic want_sum, logic want_carry, string what);
        if (sum !== want_sum || carry !== want_carry) begin
            errors++;
            $display("  FAIL: %s -> expected sum=%b carry=%b, got sum=%b carry=%b",
                      what, want_sum, want_carry, sum, carry);
        end
    endtask

    initial begin
        a = 0; b = 0; #1; check(1'b0, 1'b0, "0+0");
        a = 0; b = 1; #1; check(1'b1, 1'b0, "0+1");
        a = 1; b = 0; #1; check(1'b1, 1'b0, "1+0");
        a = 1; b = 1; #1; check(1'b0, 1'b1, "1+1");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
