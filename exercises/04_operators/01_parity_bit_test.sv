module tb;

    logic [7:0] data;
    logic       parity;

    parity_bit dut (.data(data), .parity(parity));

    int errors = 0;

    task automatic check(logic want, string what);
        if (parity !== want) begin
            errors++;
            $display("  FAIL: %s -> expected parity=%b, got %b", what, want, parity);
        end
    endtask

    initial begin
        data = 8'b0000_0000; #1; check(1'b0, "zero 1-bits (even)");
        data = 8'b0000_0001; #1; check(1'b1, "one 1-bit (odd)");
        data = 8'b0000_0011; #1; check(1'b0, "two 1-bits (even)");
        data = 8'b1000_0011; #1; check(1'b1, "three 1-bits (odd)");
        data = 8'b1111_1111; #1; check(1'b0, "eight 1-bits (even)");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
