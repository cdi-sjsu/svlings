module tb;

    state_e current, next;

    enum_case dut (.current(current), .next(next));

    int errors = 0;

    task automatic check(state_e want, string what);
        if (next !== want) begin
            errors++;
            $display("  FAIL: %s -> expected next=%s, got %s", what, want.name(), next.name());
        end
    endtask

    initial begin
        current = STATE_A; #1; check(STATE_B, "after A comes B");
        current = STATE_B; #1; check(STATE_C, "after B comes C");
        current = STATE_C; #1; check(STATE_A, "after C comes A");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
