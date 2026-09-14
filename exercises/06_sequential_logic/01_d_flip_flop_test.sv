module tb;

    logic clk, rst, d, q;

    d_flip_flop dut (.clk(clk), .rst(rst), .d(d), .q(q));

    int errors = 0;

    // A clock is just a signal that keeps flipping forever. This one
    // toggles every 5 time units, giving a 10-unit period.
    always #5 clk = ~clk;

    task automatic check(logic want, string what);
        if (q !== want) begin
            errors++;
            $display("  FAIL: %s -> expected q=%b, got %b", what, want, q);
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        d   = 0;

        @(posedge clk); #1; check(1'b0, "held in reset");

        rst = 0;
        d   = 1;
        @(posedge clk); #1; check(1'b1, "captures d=1 on the clock edge");

        d = 0;
        @(posedge clk); #1; check(1'b0, "captures d=0 on the next edge");

        d   = 1;
        rst = 1;
        @(posedge clk); #1; check(1'b0, "reset wins even while d=1");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
