// "data_bus_if" bundles a data wire and a valid wire together. "producer"
// drives them, "consumer" reads them - you're given both of those
// modules, already correct. Your job is finishing "top", which should
// wire one of each together through a shared interface instance.
//
// This is the same kind of instantiation you did back in the modules
// section - it just goes through an interface this time instead of
// individual wires.

interface data_bus_if;
    logic [7:0] data;
    logic       valid;

    modport producer (output data, output valid);
    modport consumer (input data, input valid);
endinterface

module producer (
    data_bus_if.producer bus
);
    assign bus.data  = 8'hAB;
    assign bus.valid = 1'b1;
endmodule

module consumer (
    data_bus_if.consumer bus,
    output logic [7:0]   captured,
    output logic         seen_valid
);
    assign captured   = bus.data;
    assign seen_valid = bus.valid;
endmodule

module top (
    output logic [7:0] captured,
    output logic       seen_valid
);

    data_bus_if bus();

    producer u_producer (.bus(bus));

    // TODO: instantiate "consumer" here, named "u_consumer", connecting
    // its "bus" port to the same "bus" interface instance above, and its
    // "captured"/"seen_valid" outputs to this module's own outputs of
    // the same names.

endmodule
