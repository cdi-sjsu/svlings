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
module car_alarm (
    input  logic door_open,
    input  logic key_in_ignition,
    output logic alarm
);

    assign alarm = door_open & ~key_in_ignition;

endmodule
```

A few things worth noticing:

- `module car_alarm ( ... );` opens the box and gives it a name.
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
module two_alarms (
    input  logic door_open,
    input  logic key_in_ignition,
    output logic front_alarm,
    output logic back_alarm
);

    car_alarm front (
        .door_open       (door_open),
        .key_in_ignition (key_in_ignition),
        .alarm           (front_alarm)
    );

    car_alarm back (
        .door_open       (door_open),
        .key_in_ignition (key_in_ignition),
        .alarm           (back_alarm)
    );

endmodule
```

`car_alarm front ( ... )` creates one copy ("instance") of `car_alarm`
named `front`, and `.alarm(front_alarm)` says "connect this instance's
`alarm` port to the wire called `front_alarm` out here." That
`.port_name(wire_name)` style is called a **named port connection**, and
you should basically always use it - it's self-documenting, and if the
module's port order ever changes, your instantiation still works.

## Running the checks

```
svlings run car_alarm
svlings verify
```

## Exercises in this section

1. `01_car_alarm.sv` - a module is missing one of its ports.
2. `02_two_stage_inverter.sv` - wiring up two instances of a module.
