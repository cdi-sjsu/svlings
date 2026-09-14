// An ALU - arithmetic logic unit - is the part of a processor that
// actually does the math. Given two numbers and a code saying which
// operation to perform, it produces the answer.
//
// SPECIFICATION
//
//   Inputs:  a, b   - 8-bit values to operate on
//            op     - 2 bits, picking which operation:
//
//                       op    operation        result should be
//                       ----  ---------------  ----------------
//                       2'd0  add              a + b
//                       2'd1  subtract         a - b
//                       2'd2  bitwise AND      a & b
//                       2'd3  bitwise XOR      a ^ b
//
//   Outputs: result - 8 bits, the answer
//            zero   - 1 bit, high when result is exactly zero,
//                     low otherwise
//
// Overflow doesn't matter here - 8 bits in, 8 bits out, and anything
// that doesn't fit just wraps around, which is what the + and -
// operators already do on their own.
//
// Nothing here needs to remember anything between clock ticks (there
// isn't even a clock), so this is combinational.

module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [1:0] op,
    output logic [7:0] result,
    output logic       zero
);

    // Your design goes here.

endmodule
