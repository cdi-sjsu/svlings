module tb;

    logic [7:0] value;
    logic       is_negative;

    negative_check dut (.value(value), .is_negative(is_negative));

    int errors = 0;

    task automatic check(logic want, string what);
        if (is_negative !== want) begin
            errors++;
            $display("  FAIL: %s -> expected is_negative=%b, got %b", what, want, is_negative);
        end
    endtask

    initial begin
        value = 8'h00; #1; check(1'b0, "0 is not negative");
        value = 8'h01; #1; check(1'b0, "1 is not negative");
        value = 8'h7F; #1; check(1'b0, "127 is not negative");
        value = 8'h80; #1; check(1'b1, "-128 is negative");
        value = 8'hFF; #1; check(1'b1, "-1 is negative");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
