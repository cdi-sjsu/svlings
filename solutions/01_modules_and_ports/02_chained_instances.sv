module inverter (
    input  logic a,
    output logic y
);
    assign y = ~a;
endmodule

module chained_instances (
    input  logic in,
    output logic out
);

    logic mid;

    inverter stage0 (
        .a (in),
        .y (mid)
    );

    inverter stage1 (
        .a (mid),
        .y (out)
    );

endmodule
