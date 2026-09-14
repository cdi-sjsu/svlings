# Modules and ports

A **module** is the basic building block of a hardware design. You already
met one in the welcome exercise. Think of a module as a labeled box:

```
            +----------------+
   button ->|                |
            |   hello_gate   |-> led
            |                |
            +----------------+
```

The wires going into the box are **inputs**, the wires coming out are
**outputs**. Together, inputs and outputs are called **ports** - they're
the only way anything gets in or out of the box. Whatever happens inside
the box is private; the rest of your design only ever sees the ports.

Here's the shape of it in SystemVerilog:

```systemverilog
module and_not (
    input  logic a,
    input  logic b,
    output logic y
);

    assign y = a & ~b;

endmodule
```

A few things worth noticing:

- `module and_not ( ... );` opens the box and gives it a name.
- Each port gets a direction (`input` or `output`) and a type (`logic`,
  which you'll learn more about soon).
- `endmodule` closes the box. There's no semicolon after it.

## Building bigger things out of smaller boxes

The entire point of a module is that once you've built one, you can use
it as a piece inside a bigger design, without caring how it works
internally - the same way you don't think about transistors when you flip
a light switch. Using a module inside another one is called
**instantiating** it:

```systemverilog
module two_gates (
    input  logic a,
    input  logic b,
    output logic y1,
    output logic y2
);

    and_not first (
        .a (a),
        .b (b),
        .y (y1)
    );

    and_not second (
        .a (b),
        .b (a),
        .y (y2)
    );

endmodule
```

`and_not first ( ... )` creates one copy ("instance") of `and_not` named
`first`, and `.y(y1)` says "connect this instance's `y` port to the wire
called `y1` out here." That `.port_name(wire_name)` style is called a
**named port connection**, and you should basically always use it - it's
self-documenting, and if the module's port order ever changes, your
instantiation still works.

## Running the checks

```
svlings run missing_port
svlings verify
```

## Exercises in this section

1. `01_missing_port.sv` - a module is missing one of its ports.
2. `02_chained_instances.sv` - wiring up two instances of a module.
