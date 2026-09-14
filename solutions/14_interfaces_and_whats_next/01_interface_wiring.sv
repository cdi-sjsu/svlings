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

    consumer u_consumer (
        .bus        (bus),
        .captured   (captured),
        .seen_valid (seen_valid)
    );

endmodule
