// This is the testbench for 01_hello_gate.sv.
//
// A testbench is just another piece of SystemVerilog whose only job is to
// poke at your design and check that it behaves. You don't need to edit
// this file - every exercise ships with one like it, and by the end of
// the course you'll be comfortable writing your own.

module tb;

    logic button;
    logic led;

    // This wires up an instance of YOUR module so the testbench can drive
    // its inputs and watch its output.
    hello_gate dut (
        .button (button),
        .led    (led)
    );

    int errors = 0;

    initial begin
        button = 0;
        #1; // wait one timestep for the circuit to settle
        if (led !== 1'b0) begin
            errors++;
            $display("  FAIL: button=0 -> expected led=0, got %b", led);
        end

        button = 1;
        #1;
        if (led !== 1'b1) begin
            errors++;
            $display("  FAIL: button=1 -> expected led=1, got %b", led);
        end

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
