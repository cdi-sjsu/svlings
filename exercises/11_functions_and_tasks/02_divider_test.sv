module tb;

    logic [7:0] dividend, divisor, quotient, remainder;

    divider dut (
        .dividend  (dividend),
        .divisor   (divisor),
        .quotient  (quotient),
        .remainder (remainder)
    );

    int errors = 0;

    task automatic check(logic [7:0] want_q, logic [7:0] want_r, string what);
        if (quotient !== want_q || remainder !== want_r) begin
            errors++;
            $display("  FAIL: %s -> expected quotient=%0d remainder=%0d, got quotient=%0d remainder=%0d",
                      what, want_q, want_r, quotient, remainder);
        end
    endtask

    initial begin
        dividend = 8'd10; divisor = 8'd3; #1; check(8'd3, 8'd1, "10 / 3");
        dividend = 8'd20; divisor = 8'd4; #1; check(8'd5, 8'd0, "20 / 4 (exact)");
        dividend = 8'd7;  divisor = 8'd10; #1; check(8'd0, 8'd7, "7 / 10 (smaller than divisor)");
        dividend = 8'd0;  divisor = 8'd5;  #1; check(8'd0, 8'd0, "0 / 5");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
