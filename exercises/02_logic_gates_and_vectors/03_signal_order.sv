// STOP. Before you edit anything, read the module below and predict:
// does it compile, or is it broken?
//
// If you've written software before, your instinct says broken. Line 1
// of the logic uses "both_ab", and "both_ab" isn't built until the line
// *after* it. In a program, that's using a variable before you set it.
//
// It compiles. It works. And understanding why is the single biggest
// mental shift in this whole course.
//
// SystemVerilog is not a list of instructions that run top to bottom.
// Each "assign" describes a piece of wiring that exists permanently and
// all at once - the way the wires inside a plugged-in appliance are all
// connected simultaneously, not one after another. Writing them in a
// different order doesn't change the circuit, any more than describing
// the rooms of a house in a different order moves the walls.
//
// So there is no "before" and "after" here. There's just: y is wired to
// the OR of those two signals, both_ab is wired to the AND of a and b,
// and those two facts are true at the same time, forever.

module signal_order (
    input  logic a,
    input  logic b,
    input  logic c,
    output logic y
);

    logic both_ab;
    logic c_inverted;

    assign y       = both_ab | c_inverted;
    assign both_ab = a & b;

    // TODO: c_inverted should be NOT c. Add that one assign statement.
    //
    // Put it wherever you like - above the two lines, below them, in
    // between. Then, once it passes, move it somewhere else and run it
    // again. It will still pass, every time. That is the whole lesson.

endmodule
