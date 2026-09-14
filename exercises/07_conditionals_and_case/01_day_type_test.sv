module tb;

    logic [2:0] day;
    logic       is_weekend;

    day_type dut (.day(day), .is_weekend(is_weekend));

    int errors = 0;

    task automatic check(logic want, string what);
        if (is_weekend !== want) begin
            errors++;
            $display("  FAIL: %s -> expected is_weekend=%b, got %b", what, want, is_weekend);
        end
    endtask

    initial begin
        day = 3'd0; #1; check(1'b1, "Sunday");
        day = 3'd1; #1; check(1'b0, "Monday");
        day = 3'd2; #1; check(1'b0, "Tuesday");
        day = 3'd3; #1; check(1'b0, "Wednesday");
        day = 3'd4; #1; check(1'b0, "Thursday");
        day = 3'd5; #1; check(1'b0, "Friday");
        day = 3'd6; #1; check(1'b1, "Saturday");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
