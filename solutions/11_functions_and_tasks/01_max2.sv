function automatic logic [7:0] max2(logic [7:0] a, logic [7:0] b);
    if (a > b)
        return a;
    else
        return b;
endfunction

module bigger_of_two (
    input  logic [7:0] x,
    input  logic [7:0] y,
    output logic [7:0] biggest
);

    always_comb begin
        biggest = max2(x, y);
    end

endmodule
