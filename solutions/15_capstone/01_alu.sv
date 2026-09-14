// One correct way to write it. There are several - if yours passes and
// you can explain why, yours is fine too.

module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [1:0] op,
    output logic [7:0] result,
    output logic       zero
);

    always_comb begin
        case (op)
            2'd0:    result = a + b;
            2'd1:    result = a - b;
            2'd2:    result = a & b;
            2'd3:    result = a ^ b;
            default: result = 8'd0;
        endcase
    end

    // "no bit of result is set" - reduction-OR gives 1 if any bit is
    // set, so invert it.
    assign zero = ~|result;

endmodule
