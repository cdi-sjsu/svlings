module tb;

    logic [3:0] in, out;

    inverter_array dut (.in(in), .out(out));

    int errors = 0;

    task automatic check(logic [3:0] want, string what);
        if (out !== want) begin
            errors++;
            $display("  FAIL: %s -> expected out=%b, got %b", what, want, out);
        end
    endtask

    initial begin
        in = 4'b0000; #1; check(4'b1111, "all zeros -> all ones");
        in = 4'b1111; #1; check(4'b0000, "all ones -> all zeros");
        in = 4'b1010; #1; check(4'b0101, "alternating");
        in = 4'b0001; #1; check(4'b1110, "single low bit");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
