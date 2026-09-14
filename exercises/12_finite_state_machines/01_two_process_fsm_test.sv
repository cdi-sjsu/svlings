module tb;

    logic   clk, rst, tick;
    state_e state_out;

    two_process_fsm dut (.clk(clk), .rst(rst), .tick(tick), .state_out(state_out));

    int errors = 0;

    always #5 clk = ~clk;

    task automatic check(state_e want, string what);
        if (state_out !== want) begin
            errors++;
            $display("  FAIL: %s -> expected state=%s, got %s", what, want.name(), state_out.name());
        end
    endtask

    initial begin
        clk = 0; rst = 1; tick = 0;
        @(posedge clk); #1; check(STATE_A, "reset starts at STATE_A");

        rst = 0; tick = 1;
        @(posedge clk); #1; check(STATE_B, "STATE_A -> STATE_B");
        @(posedge clk); #1; check(STATE_C, "STATE_B -> STATE_C");
        @(posedge clk); #1; check(STATE_A, "STATE_C -> STATE_A");

        // Without a tick, the state should just sit still.
        tick = 0;
        @(posedge clk); #1; check(STATE_A, "no tick, stays put");
        @(posedge clk); #1; check(STATE_A, "still no tick, still put");

        tick = 1;
        @(posedge clk); #1; check(STATE_B, "ticking resumes the cycle");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
