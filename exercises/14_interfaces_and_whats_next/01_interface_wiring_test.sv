module tb;

    logic [7:0] captured;
    logic       seen_valid;

    top dut (.captured(captured), .seen_valid(seen_valid));

    int errors = 0;

    initial begin
        #1;
        if (captured !== 8'hAB) begin
            errors++;
            $display("  FAIL: expected captured=0xAB, got 0x%h", captured);
        end
        if (seen_valid !== 1'b1) begin
            errors++;
            $display("  FAIL: expected seen_valid=1, got %b", seen_valid);
        end

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
