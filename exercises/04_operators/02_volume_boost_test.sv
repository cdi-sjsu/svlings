module tb;

    logic [7:0] level, boosted_level;
    logic       boost;

    volume_boost dut (.level(level), .boost(boost), .boosted_level(boosted_level));

    int errors = 0;

    task automatic check(logic [7:0] want, string what);
        if (boosted_level !== want) begin
            errors++;
            $display("  FAIL: %s -> expected boosted_level=%0d, got %0d", what, want, boosted_level);
        end
    endtask

    initial begin
        level = 8'd10; boost = 0; #1; check(8'd10, "no boost, unchanged");
        level = 8'd10; boost = 1; #1; check(8'd20, "boost, doubled");
        level = 8'd0;  boost = 1; #1; check(8'd0,  "boost of zero is still zero");
        level = 8'd64; boost = 1; #1; check(8'd128, "boost of 64");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
