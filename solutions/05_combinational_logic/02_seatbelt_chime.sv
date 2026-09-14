module seatbelt_chime (
    input  logic driving,
    input  logic seatbelt_on,
    output logic chime
);

    always_comb begin
        if (driving && !seatbelt_on)
            chime = 1'b1;
        else
            chime = 1'b0;
    end

endmodule
