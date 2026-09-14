module tb;

    logic driving, seatbelt_on, chime;

    seatbelt_chime dut (.driving(driving), .seatbelt_on(seatbelt_on), .chime(chime));

    int errors = 0;

    task automatic check(logic want, string what);
        if (chime !== want) begin
            errors++;
            $display("  FAIL: %s -> expected chime=%b, got %b", what, want, chime);
        end
    endtask

    initial begin
        driving = 0; seatbelt_on = 0; #1; check(1'b0, "parked, no belt");
        driving = 1; seatbelt_on = 0; #1; check(1'b1, "driving, no belt");
        driving = 1; seatbelt_on = 1; #1; check(1'b0, "driving, belted");
        driving = 0; seatbelt_on = 1; #1; check(1'b0, "parked, belted");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
