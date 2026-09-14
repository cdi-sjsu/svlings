// The logic inside this module is already correct: y is driven as
// "a AND NOT b". The problem is the port list at the top - the module
// uses a signal called "y", but never declared it as an output. Add the
// missing port.

module missing_port (
    input  logic a,
    input  logic b
    // TODO: this module needs one more port here: an output called
    // "y". Don't forget the comma after "b" once you add it.
);

    assign y = a & ~b;

endmodule
