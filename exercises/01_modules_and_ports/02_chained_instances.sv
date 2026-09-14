// This file has two modules in it. That's completely normal - a file is
// just a container for modules, and it's common to keep small, related
// ones together.
//
// "inverter" below is finished and correct, don't change it. Your job is
// to finish "chained_instances", which should chain two inverters back
// to back: in -> [inverter] -> mid -> [inverter] -> out.
//
// Notice that inverting a signal twice just gives you the signal back -
// that's a useful thing to keep in mind once you get to the testbench.

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

    logic mid; // the wire connecting the two inverters together

    inverter stage0 (
        .a (in),
        .y (mid)
    );

    // TODO: instantiate a second inverter named "stage1". It should take
    // "mid" as its input and drive "out" as its output. Copy the shape
    // of "stage0" above and change the names.

endmodule
