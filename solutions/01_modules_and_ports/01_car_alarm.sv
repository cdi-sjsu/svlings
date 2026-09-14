module car_alarm (
    input  logic door_open,
    input  logic key_in_ignition,
    output logic alarm
);

    assign alarm = door_open & ~key_in_ignition;

endmodule
