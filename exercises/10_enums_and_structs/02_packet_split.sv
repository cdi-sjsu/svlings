// "instr" bundles two fields into one struct: a 2-bit opcode and a 6-bit
// operand. This module should pull those two fields back apart into
// separate outputs.

typedef struct packed {
    logic [1:0] opcode;
    logic [5:0] operand;
} instruction_t;

module packet_split (
    input  instruction_t instr,
    output logic [1:0]   opcode,
    output logic [5:0]   operand
);

    always_comb begin
        // TODO: pull instr.opcode and instr.operand out into the two
        // outputs above.
        opcode  = 2'd0;
        operand = 6'd0;
    end

endmodule
