module tb;

    logic [7:0] value;
    logic [1:0] band;

    immediate_assertion dut (.value(value), .band(band));

    int errors = 0;

    task automatic check(logic [1:0] want, string what);
        if (band !== want) begin
            errors++;
            $display("  FAIL: %s -> expected band=%0d, got %0d", what, want, band);
        end
    endtask

    initial begin
        value = 8'd10; #1; check(2'd0, "10 is band 0");
        value = 8'd19; #1; check(2'd0, "19 is still band 0");
        value = 8'd20; #1; check(2'd1, "20 is band 1");
        value = 8'd29; #1; check(2'd1, "29 is still band 1");
        value = 8'd30; #1; check(2'd2, "30 is band 2");
        value = 8'd80; #1; check(2'd2, "80 is definitely band 2");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
