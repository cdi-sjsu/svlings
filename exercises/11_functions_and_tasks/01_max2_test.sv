module tb;

    logic [7:0] x, y, biggest;

    bigger_of_two dut (.x(x), .y(y), .biggest(biggest));

    int errors = 0;

    task automatic check(logic [7:0] want, string what);
        if (biggest !== want) begin
            errors++;
            $display("  FAIL: %s -> expected biggest=%0d, got %0d", what, want, biggest);
        end
    endtask

    initial begin
        x = 8'd5;  y = 8'd10; #1; check(8'd10, "y is bigger");
        x = 8'd99; y = 8'd3;  #1; check(8'd99, "x is bigger");
        x = 8'd7;  y = 8'd7;  #1; check(8'd7,  "tied");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
