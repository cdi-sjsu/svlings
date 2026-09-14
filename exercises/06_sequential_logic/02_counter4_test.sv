module tb;

    logic       clk, rst, enable;
    logic [3:0] count;

    counter4 dut (.clk(clk), .rst(rst), .enable(enable), .count(count));

    int errors = 0;

    always #5 clk = ~clk;

    task automatic check(logic [3:0] want, string what);
        if (count !== want) begin
            errors++;
            $display("  FAIL: %s -> expected count=%0d, got %0d", what, want, count);
        end
    endtask

    initial begin
        clk = 0; rst = 1; enable = 0;
        @(posedge clk); #1; check(4'd0, "held in reset");

        rst = 0; enable = 1;
        @(posedge clk); #1; check(4'd1, "counts to 1");
        @(posedge clk); #1; check(4'd2, "counts to 2");
        @(posedge clk); #1; check(4'd3, "counts to 3");

        enable = 0;
        @(posedge clk); #1; check(4'd3, "holds while disabled");
        @(posedge clk); #1; check(4'd3, "still holding");

        enable = 1;
        @(posedge clk); #1; check(4'd4, "resumes counting");

        rst = 1;
        @(posedge clk); #1; check(4'd0, "reset overrides enable");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
