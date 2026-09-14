# Interfaces, and what's next

## Interfaces: bundling signals that travel together

Back in the modules section, connecting two modules meant listing every
wire individually: `.data(data), .valid(valid), .ready(ready), ...`. Once
a connection has several signals that always travel together, that gets
repetitive and error-prone - it's easy to typo one connection and not
notice. An `interface` bundles them into a single named thing you pass
around instead:

```systemverilog
interface data_bus_if;
    logic [7:0] data;
    logic       valid;

    modport producer (output data, output valid);
    modport consumer (input data, input valid);
endinterface
```

A `modport` (short for "module port") describes how one particular
module is allowed to use the interface - here, whoever plays "producer"
drives `data` and `valid`, and whoever plays "consumer" only reads them.
Using a module port on an interface:

```systemverilog
module producer (
    data_bus_if.producer bus
);
    assign bus.data  = 8'hAB;
    assign bus.valid = 1'b1;
endmodule
```

And wiring two modules together through one shared interface instance:

```systemverilog
data_bus_if bus();

producer u_producer (.bus(bus));
consumer u_consumer (.bus(bus), .captured(captured), .seen_valid(seen_valid));
```

One connection, `.bus(bus)`, instead of one per signal. This becomes
genuinely valuable once an interface is carrying a dozen signals instead
of two - which is completely normal for real bus protocols.

## Running the checks

```
svlings run interface_wiring
svlings verify
```

## Exercise in this section

1. `01_interface_wiring.sv` - connect two modules through a shared interface.

## You've finished Phase 1

If everything up to here is green, you've genuinely covered the core of
the language: modules and ports, every everyday operator, combinational
and sequential logic, `case`/`casez`, parameters and generate blocks,
arrays and memories, enums and structs, functions and tasks, finite
state machines, writing your own checks and assertions, and now
interfaces. That's enough SystemVerilog to read real, professionally
written RTL and start writing your own small designs from scratch - not
a toy subset of the language, the actual thing.

svlings is a living course, and this is Phase 1 on purpose - it covers
*the language itself*, deliberately leaving out the parts that are
really about advanced *verification methodology* rather than
SystemVerilog as a language: classes and object-oriented testbenches,
randomization and constrained-random stimulus, functional coverage,
UVM, and calling out to C via the DPI. Those are real, valuable things
to learn next, and they deserve a course of their own once you're
standing on solid ground - which, if you've made it here, you now are.

Thank you for going through this. Go build something.
