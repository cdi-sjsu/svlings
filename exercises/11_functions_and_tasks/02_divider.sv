// A task that computes long division by repeated subtraction: keep
// taking "divisor" away from "remainder" and counting how many times you
// could do it - that count is the quotient, and whatever's left over is
// the remainder.
//
// Unlike a function, this task reports two results at once (quotient
// and remainder), which is exactly the kind of situation tasks are for.

task automatic divide(
    input  logic [7:0] dividend,
    input  logic [7:0] divisor,
    output logic [7:0] quotient,
    output logic [7:0] remainder
);
    quotient  = 8'd0;
    remainder = dividend;
    // TODO: while remainder is still >= divisor, subtract divisor from
    // remainder and add 1 to quotient.
endtask

module divider (
    input  logic [7:0] dividend,
    input  logic [7:0] divisor,
    output logic [7:0] quotient,
    output logic [7:0] remainder
);

    always_comb begin
        divide(dividend, divisor, quotient, remainder);
    end

endmodule
