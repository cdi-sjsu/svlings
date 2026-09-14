module volume_boost (
    input  logic [7:0] level,
    input  logic       boost,
    output logic [7:0] boosted_level
);

    assign boosted_level = boost ? (level << 1) : level;

endmodule
