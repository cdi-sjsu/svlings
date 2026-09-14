module tb;

    logic       clk, we;
    logic [1:0] addr;
    logic [7:0] din, dout;

    simple_ram dut (.clk(clk), .we(we), .addr(addr), .din(din), .dout(dout));

    int errors = 0;

    always #5 clk = ~clk;

    task automatic check(logic [7:0] want, string what);
        if (dout !== want) begin
            errors++;
            $display("  FAIL: %s -> expected dout=%0d, got %0d", what, want, dout);
        end
    endtask

    initial begin
        clk = 0;

        // Write 3 different values into 3 different addresses.
        we = 1; addr = 2'd0; din = 8'd11; @(posedge clk); #1;
        we = 1; addr = 2'd1; din = 8'd22; @(posedge clk); #1;
        we = 1; addr = 2'd2; din = 8'd33; @(posedge clk); #1;

        we = 0;

        addr = 2'd0; #1; check(8'd11, "readback addr 0");
        addr = 2'd1; #1; check(8'd22, "readback addr 1");
        addr = 2'd2; #1; check(8'd33, "readback addr 2");

        // Overwrite addr 0 and make sure the old value is really gone.
        we = 1; addr = 2'd0; din = 8'd99; @(posedge clk); #1;
        we = 0;
        addr = 2'd0; #1; check(8'd99, "addr 0 after overwrite");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
