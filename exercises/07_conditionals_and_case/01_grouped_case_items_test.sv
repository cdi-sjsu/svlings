module tb;

    logic [2:0] sel;
    logic       hit;

    grouped_case_items dut (.sel(sel), .hit(hit));

    int errors = 0;

    task automatic check(logic want, string what);
        if (hit !== want) begin
            errors++;
            $display("  FAIL: %s -> expected hit=%b, got %b", what, want, hit);
        end
    endtask

    initial begin
        sel = 3'd0; #1; check(1'b1, "sel=0");
        sel = 3'd1; #1; check(1'b0, "sel=1");
        sel = 3'd2; #1; check(1'b0, "sel=2");
        sel = 3'd3; #1; check(1'b0, "sel=3");
        sel = 3'd4; #1; check(1'b0, "sel=4");
        sel = 3'd5; #1; check(1'b0, "sel=5");
        sel = 3'd6; #1; check(1'b1, "sel=6");
        sel = 3'd7; #1; check(1'b0, "sel=7");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
