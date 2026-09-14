module tb;

    logic clk, rst, bit_in, detected;

    sequence_101 dut (.clk(clk), .rst(rst), .bit_in(bit_in), .detected(detected));

    int errors = 0;

    always #5 clk = ~clk;

    // Feed one bit in, wait for the edge that consumes it, then check
    // what the machine says afterwards.
    task automatic step(logic bit_value, logic want_detected, string what);
        bit_in = bit_value;
        @(posedge clk); #1;
        if (detected !== want_detected) begin
            errors++;
            $display("  FAIL: %s -> expected detected=%b, got %b", what, want_detected, detected);
        end
    endtask

    initial begin
        clk = 0; rst = 1; bit_in = 0;
        @(posedge clk); #1;
        rst = 0;

        // Stream: 1 0 1 0 1 1 0 1 0 0 1
        //             ^     ^       ^
        //         detections here, including the overlap at bit 5
        step(1'b1, 1'b0, "bit 1: '1'");
        step(1'b0, 1'b0, "bit 2: '10'");
        step(1'b1, 1'b1, "bit 3: '101' - first detection");
        step(1'b0, 1'b0, "bit 4: '1010'");
        step(1'b1, 1'b1, "bit 5: '10101' - overlapping detection");
        step(1'b1, 1'b0, "bit 6: '101011' - streak broken");
        step(1'b0, 1'b0, "bit 7: partial match again");
        step(1'b1, 1'b1, "bit 8: third detection");
        step(1'b0, 1'b0, "bit 9: no detection");
        step(1'b0, 1'b0, "bit 10: two zeros, nothing pending");
        step(1'b1, 1'b0, "bit 11: only one bit of a new pattern");

        // Reset in the middle of a partial match should wipe it.
        step(1'b0, 1'b0, "bit 12: now sitting on '10'");
        rst = 1;
        @(posedge clk); #1;
        rst = 0;
        step(1'b1, 1'b0, "after reset, a lone 1 must not complete anything");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
