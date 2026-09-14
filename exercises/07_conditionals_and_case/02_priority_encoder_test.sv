module tb;

    logic [3:0] request;
    logic [1:0] grant;

    priority_encoder dut (.request(request), .grant(grant));

    int errors = 0;

    task automatic check(logic [1:0] want, string what);
        if (grant !== want) begin
            errors++;
            $display("  FAIL: %s -> expected grant=%0d, got %0d", what, want, grant);
        end
    endtask

    initial begin
        request = 4'b0000; #1; check(2'd0, "nobody requesting");
        request = 4'b0001; #1; check(2'd0, "only device 0");
        request = 4'b0010; #1; check(2'd1, "only device 1");
        request = 4'b0100; #1; check(2'd2, "only device 2");
        request = 4'b1000; #1; check(2'd3, "only device 3");
        request = 4'b1111; #1; check(2'd3, "everyone at once, 3 wins");
        request = 4'b0110; #1; check(2'd2, "1 and 2, higher one wins");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
