module tb;

    logic [7:0] data8;
    logic [3:0] count8;
    logic [3:0] data4;
    logic [3:0] count4;

    // Two instances of the same module, two different widths - this is
    // the whole point of a parameter.
    popcount u_wide (.data(data8), .count(count8));
    popcount #(.WIDTH(4)) u_narrow (.data(data4), .count(count4));

    int errors = 0;

    task automatic check8(logic [3:0] want, string what);
        if (count8 !== want) begin
            errors++;
            $display("  FAIL: %s -> expected count8=%0d, got %0d", what, want, count8);
        end
    endtask

    task automatic check4(logic [3:0] want, string what);
        if (count4 !== want) begin
            errors++;
            $display("  FAIL: %s -> expected count4=%0d, got %0d", what, want, count4);
        end
    endtask

    initial begin
        data8 = 8'b0000_0000; #1; check8(4'd0, "8-bit: nothing set");
        data8 = 8'b0000_0001; #1; check8(4'd1, "8-bit: one bit");
        data8 = 8'b1111_1111; #1; check8(4'd8, "8-bit: all bits");
        data8 = 8'b1010_1010; #1; check8(4'd4, "8-bit: alternating");

        data4 = 4'b0000; #1; check4(4'd0, "4-bit: nothing set");
        data4 = 4'b1111; #1; check4(4'd4, "4-bit: all bits");
        data4 = 4'b1001; #1; check4(4'd2, "4-bit: two bits");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
