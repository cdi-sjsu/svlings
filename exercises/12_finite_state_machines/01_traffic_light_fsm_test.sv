module tb;

    logic   clk, rst, tick;
    color_e light;

    traffic_light_fsm dut (.clk(clk), .rst(rst), .tick(tick), .light(light));

    int errors = 0;

    always #5 clk = ~clk;

    task automatic check(color_e want, string what);
        if (light !== want) begin
            errors++;
            $display("  FAIL: %s -> expected light=%s, got %s", what, want.name(), light.name());
        end
    endtask

    initial begin
        clk = 0; rst = 1; tick = 0;
        @(posedge clk); #1; check(RED, "reset starts at red");

        rst = 0; tick = 1;
        @(posedge clk); #1; check(GREEN,  "red -> green");
        @(posedge clk); #1; check(YELLOW, "green -> yellow");
        @(posedge clk); #1; check(RED,    "yellow -> red");

        // Without a tick, the light should just sit still.
        tick = 0;
        @(posedge clk); #1; check(RED, "no tick, stays red");
        @(posedge clk); #1; check(RED, "still no tick, still red");

        tick = 1;
        @(posedge clk); #1; check(GREEN, "ticking resumes the cycle");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
