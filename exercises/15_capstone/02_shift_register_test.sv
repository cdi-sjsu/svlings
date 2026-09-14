module tb;

    logic       clk, rst, serial_in;
    logic [7:0] parallel_out;

    shift_register dut (
        .clk          (clk),
        .rst          (rst),
        .serial_in    (serial_in),
        .parallel_out (parallel_out)
    );

    int errors = 0;

    always #5 clk = ~clk;

    task automatic check(logic [7:0] want, string what);
        if (parallel_out !== want) begin
            errors++;
            $display("  FAIL: %s -> expected parallel_out=%b, got %b", what, want, parallel_out);
        end
    endtask

    // Feed one bit in, wait for the edge that consumes it, then check.
    task automatic shift_in(logic bit_value, logic [7:0] want, string what);
        serial_in = bit_value;
        @(posedge clk); #1;
        check(want, what);
    endtask

    initial begin
        clk = 0; rst = 1; serial_in = 0;
        @(posedge clk); #1; check(8'b0000_0000, "reset clears it");

        rst = 0;

        // Shift in 1, 0, 1, 1 one at a time and watch them march up.
        shift_in(1'b1, 8'b0000_0001, "first bit in");
        shift_in(1'b0, 8'b0000_0010, "second bit, first one shifted up");
        shift_in(1'b1, 8'b0000_0101, "third bit");
        shift_in(1'b1, 8'b0000_1011, "fourth bit");

        // Fill it the rest of the way with 0s and watch the pattern
        // walk out the top.
        shift_in(1'b0, 8'b0001_0110, "fifth");
        shift_in(1'b0, 8'b0010_1100, "sixth");
        shift_in(1'b0, 8'b0101_1000, "seventh");
        shift_in(1'b0, 8'b1011_0000, "eighth - register now full");
        shift_in(1'b0, 8'b0110_0000, "ninth - the oldest bit falls off the end");

        // Reset should clear it no matter what's in there.
        rst = 1;
        @(posedge clk); #1; check(8'b0000_0000, "reset clears a full register");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
