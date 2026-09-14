module tb;

    logic [7:0] a, b, result;
    logic [1:0] op;
    logic       zero;

    alu dut (.a(a), .b(b), .op(op), .result(result), .zero(zero));

    int errors = 0;

    task automatic check(logic [7:0] want_result, logic want_zero, string what);
        if (result !== want_result || zero !== want_zero) begin
            errors++;
            $display("  FAIL: %s -> expected result=%0d zero=%b, got result=%0d zero=%b",
                      what, want_result, want_zero, result, zero);
        end
    endtask

    initial begin
        // add
        a = 8'd10; b = 8'd5;  op = 2'd0; #1; check(8'd15,  1'b0, "10 + 5");
        a = 8'd0;  b = 8'd0;  op = 2'd0; #1; check(8'd0,   1'b1, "0 + 0 sets zero");
        a = 8'd200; b = 8'd100; op = 2'd0; #1; check(8'd44, 1'b0, "200 + 100 wraps");

        // subtract
        a = 8'd10; b = 8'd5;  op = 2'd1; #1; check(8'd5,   1'b0, "10 - 5");
        a = 8'd7;  b = 8'd7;  op = 2'd1; #1; check(8'd0,   1'b1, "7 - 7 sets zero");
        a = 8'd0;  b = 8'd1;  op = 2'd1; #1; check(8'd255, 1'b0, "0 - 1 wraps");

        // bitwise and
        a = 8'hF0; b = 8'h3C; op = 2'd2; #1; check(8'h30,  1'b0, "F0 & 3C");
        a = 8'hF0; b = 8'h0F; op = 2'd2; #1; check(8'h00,  1'b1, "F0 & 0F sets zero");

        // bitwise xor
        a = 8'hFF; b = 8'h0F; op = 2'd3; #1; check(8'hF0,  1'b0, "FF ^ 0F");
        a = 8'hA5; b = 8'hA5; op = 2'd3; #1; check(8'h00,  1'b1, "A5 ^ A5 sets zero");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
