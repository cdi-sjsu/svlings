// A car alarm: it should sound whenever the door is open but the key
// isn't in the ignition (i.e. someone left the door open without
// actually starting the car).
//
// The logic inside this module is already correct. The problem is the
// port list at the top: the module uses a signal called "alarm", but
// never declared it as an output. Add the missing port.

module car_alarm (
    input  logic door_open,
    input  logic key_in_ignition
    // TODO: this module needs one more port here: an output called
    // "alarm". Don't forget the comma after key_in_ignition once you
    // add it.
);

    assign alarm = door_open & ~key_in_ignition;

endmodule
