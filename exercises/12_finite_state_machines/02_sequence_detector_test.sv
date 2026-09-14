module tb;

    logic clk, rst, bit_in, detected;

    sequence_detector dut (
        .clk      (clk),
        .rst      (rst),
        .bit_in   (bit_in),
        .detected (detected)
    );

    int errors = 0;

    always #5 clk = ~clk;

    task automatic check(logic want, string what);
        if (detected !== want) begin
            errors++;
            $display("  FAIL: %s -> expected detected=%b, got %b", what, want, detected);
        end
    endtask

    // Feeds one bit in, waits for the clock edge that consumes it, then
    // checks "detected" against what it should be right after.
    task automatic step(logic bit_value, logic want_detected, string what);
        bit_in = bit_value;
        @(posedge clk); #1;
        check(want_detected, what);
    endtask

    initial begin
        clk = 0; rst = 1; bit_in = 0;
        @(posedge clk); #1;
        rst = 0;

        // Feed the stream: 1, 1, 0, 1, 1, 1, 0
        step(1'b1, 1'b0, "bit 1: only one 1 so far");
        step(1'b1, 1'b1, "bit 2: two 1s in a row!");
        step(1'b0, 1'b0, "bit 3: a 0 breaks the streak");
        step(1'b1, 1'b0, "bit 4: starting a new streak");
        step(1'b1, 1'b1, "bit 5: two in a row again");
        step(1'b1, 1'b1, "bit 6: still two in a row (overlapping)");
        step(1'b0, 1'b0, "bit 7: streak broken again");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
