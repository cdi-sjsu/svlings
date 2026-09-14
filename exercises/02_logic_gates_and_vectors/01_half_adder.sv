// A half adder adds two single bits together. Since 1 + 1 = 2, and a
// single bit can't hold the number 2, the result needs two outputs:
//
//   sum   - the ones place of the answer (0 or 1)
//   carry - the twos place, i.e. "did this overflow into the next digit"
//
//   a  b  | sum  carry
//   0  0  |  0     0
//   0  1  |  1     0
//   1  0  |  1     0
//   1  1  |  0     1      <- 1 + 1 = 2, written as "10" in binary
//
// Notice that "sum" is 1 exactly when a and b are different, and "carry"
// is 1 exactly when both are 1. Two gates you already know do exactly
// that.

module half_adder (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);

    // TODO: drive "sum" with the gate that's 1 when a and b differ.
    assign sum = 1'b0;

    // TODO: drive "carry" with the gate that's 1 when a and b are both 1.
    assign carry = 1'b0;

endmodule
