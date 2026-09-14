module tristate_driver (
    input  logic       enable,
    input  logic [7:0] data,
    output logic [7:0] bus
);

    assign bus = enable ? data : 8'bz;

endmodule
