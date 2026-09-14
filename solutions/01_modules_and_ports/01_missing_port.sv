module missing_port (
    input  logic a,
    input  logic b,
    output logic y
);

    assign y = a & ~b;

endmodule
