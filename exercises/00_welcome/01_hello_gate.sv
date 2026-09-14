// Welcome to svlings.
//
// This first exercise isn't really about SystemVerilog yet - it's about
// getting comfortable with the loop you'll repeat for the rest of the
// course:
//
//   1. read the broken thing below
//   2. fix it
//   3. save the file
//   4. run:  svlings verify
//
// That's it. That's the whole course, one small circuit at a time.
//
// ---------------------------------------------------------------------
//
// A "module" is the basic building block of a hardware design. Picture a
// small box with wires going into it and wires coming out of it. Inside
// the box, you describe what it does with those wires. That's a module.
//
// The box below is wired up to a button and an LED. It's supposed to
// light the LED whenever the button is held down.

module hello_gate (
    input  logic button,
    output logic led
);

    // TODO: the line below is a comment (it starts with "//"), so
    // SystemVerilog skips right over it. Delete the "// " at the start
    // of the next line so it actually takes effect.

    // assign led = button;

endmodule
