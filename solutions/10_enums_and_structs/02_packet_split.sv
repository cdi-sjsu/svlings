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
        opcode  = instr.opcode;
        operand = instr.operand;
    end

endmodule
