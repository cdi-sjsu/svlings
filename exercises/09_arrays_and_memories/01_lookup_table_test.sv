module tb;

    logic [1:0] addr;
    logic [7:0] value;

    lookup_table dut (.addr(addr), .value(value));

    int errors = 0;

    task automatic check(logic [7:0] want, string what);
        if (value !== want) begin
            errors++;
            $display("  FAIL: %s -> expected value=%0d, got %0d", what, want, value);
        end
    endtask

    initial begin
        addr = 2'd0; #1; check(8'd10, "addr 0");
        addr = 2'd1; #1; check(8'd20, "addr 1");
        addr = 2'd2; #1; check(8'd30, "addr 2");
        addr = 2'd3; #1; check(8'd40, "addr 3");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
