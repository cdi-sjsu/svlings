task automatic divide(
    input  logic [7:0] dividend,
    input  logic [7:0] divisor,
    output logic [7:0] quotient,
    output logic [7:0] remainder
);
    quotient  = 8'd0;
    remainder = dividend;
    while (remainder >= divisor) begin
        remainder -= divisor;
        quotient++;
    end
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
