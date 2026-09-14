module tb;

    logic [7:0] in, out;

    nibble_swap dut (.in(in), .out(out));

    int errors = 0;

    task automatic check(logic [7:0] want, string what);
        if (out !== want) begin
            errors++;
            $display("  FAIL: %s -> expected out=%b, got %b", what, want, out);
        end
    endtask

    initial begin
        in = 8'b1111_0000; #1; check(8'b0000_1111, "0xF0");
        in = 8'b1010_0101; #1; check(8'b0101_1010, "0xA5");
        in = 8'h00;        #1; check(8'h00,         "0x00");
        in = 8'hFF;        #1; check(8'hFF,         "0xFF");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
