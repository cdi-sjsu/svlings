module tb;

    color_e current, next;

    next_color dut (.current(current), .next(next));

    int errors = 0;

    task automatic check(color_e want, string what);
        if (next !== want) begin
            errors++;
            $display("  FAIL: %s -> expected next=%s, got %s", what, want.name(), next.name());
        end
    endtask

    initial begin
        current = RED;    #1; check(GREEN,  "after red comes green");
        current = GREEN;  #1; check(YELLOW, "after green comes yellow");
        current = YELLOW; #1; check(RED,    "after yellow comes red");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
