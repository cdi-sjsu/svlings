module tb;

    instruction_t instr;
    logic [1:0]   opcode;
    logic [5:0]   operand;

    packet_split dut (.instr(instr), .opcode(opcode), .operand(operand));

    int errors = 0;

    task automatic check(logic [1:0] want_op, logic [5:0] want_operand, string what);
        if (opcode !== want_op || operand !== want_operand) begin
            errors++;
            $display("  FAIL: %s -> expected opcode=%0d operand=%0d, got opcode=%0d operand=%0d",
                      what, want_op, want_operand, opcode, operand);
        end
    endtask

    initial begin
        instr = '{opcode: 2'b01, operand: 6'd5};
        #1; check(2'b01, 6'd5, "first packet");

        instr = '{opcode: 2'b11, operand: 6'd42};
        #1; check(2'b11, 6'd42, "second packet");

        if (errors == 0) begin
            $display("SVLINGS: ALL CHECKS PASSED");
            $finish;
        end else begin
            $display("SVLINGS: %0d CHECK(S) FAILED", errors);
            $fatal(1);
        end
    end

endmodule
