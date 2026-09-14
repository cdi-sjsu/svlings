// A function that returns whichever of its two arguments is bigger,
// used by the module below it.

function automatic logic [7:0] max2(logic [7:0] a, logic [7:0] b);
    // TODO: return a if it's bigger, otherwise return b.
    return 8'd0;
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
