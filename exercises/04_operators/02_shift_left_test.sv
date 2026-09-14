module tb;

    logic [7:0] value, result;
    logic       double_it;

    shift_left dut (.value(value), .double_it(double_it), .result(result));

    int errors = 0;

    task automatic check(logic [7:0] want, string what);
        if (result !== want) begin
            errors++;
            $display("  FAIL: %s -> expected result=%0d, got %0d", what, want, result);
        end
    endtask

    initial begin
        value = 8'd10; double_it = 0; #1; check(8'd10, "no shift, unchanged");
        value = 8'd10; double_it = 1; #1; check(8'd20, "shifted, doubled");
        value = 8'd0;  double_it = 1; #1; check(8'd0,  "shift of zero is still zero");
        value = 8'd64; double_it = 1; #1; check(8'd128, "shift of 64");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
