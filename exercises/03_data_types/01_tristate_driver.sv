// Shared buses work like a walkie-talkie channel: only one person should
// "talk" (drive the wire) at a time, and everyone else needs to stay
// quiet. In hardware, "staying quiet" means driving high-impedance (Z)
// instead of a 0 or a 1 - it's the electrical equivalent of letting go
// of the wire entirely.
//
// This module should put "data" onto "bus" whenever "enable" is high,
// and let go of the bus (drive all Z) whenever "enable" is low.

module tristate_driver (
    input  logic       enable,
    input  logic [7:0] data,
    output logic [7:0] bus
);

    // TODO: use enable ? ... : ... so that bus follows data when enable
    // is high, and becomes 8'bz (all eight bits high-impedance) when
    // enable is low.
    assign bus = data;

endmodule
