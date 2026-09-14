# Data types

So far every wire has quietly been either 0 or 1. Real hardware has two
more states worth knowing about:

- **X** - unknown. Simulators use this for "I have no idea what this
  value is," usually because nothing has driven it yet.
- **Z** - high impedance. This means "disconnected" - nobody is actively
  driving this wire right now. You'll see this on shared buses, where
  several chips take turns driving the same wires and everyone else has
  to stay quiet (drive Z) while it's not their turn.

`logic` is SystemVerilog's default type, and it can hold all four values:
0, 1, X, or Z. That's why it's called **4-state**. Older Verilog forced
you to pick between `wire` and `reg` depending on how a signal was
driven; `logic` in SystemVerilog replaces both for ordinary signals
(there are still a few narrow cases, like a wire driven from two places
at once, where you need plain `wire` - you'll run into those later).

There's also a family of **2-state** types - `bit`, `int`, `byte` - which
can only ever be 0 or 1, never X or Z. These exist mainly for
testbenches and plain computation, where you don't want to deal with
unknowns. For anything that's actually part of your circuit's design,
stick with `logic`.

A comparison gotcha: the ordinary `==` operator treats X and Z like
"maybe equal, maybe not" and can itself return X. To check for an exact
match including X and Z, use `===` instead (and `!==` for "not exactly
equal"). Every testbench in this course already uses `===`/`!==` for
you, so you don't need to worry about it yet, just recognize it when
you see it.

## Picking between two values: the ternary operator

The first exercise below asks you to drive an output with one of two
values depending on a condition. SystemVerilog has a compact way to
write exactly that, called the **ternary operator**:

```systemverilog
assign result = condition ? value_if_true : value_if_false;
```

Read it as "if `condition`, use `value_if_true`, otherwise use
`value_if_false`." It's just a more compact `if`/`else` for a single
expression, and you'll see it constantly once you start looking for it.

## Signed numbers

By default, a `logic [7:0]` vector is just 8 raw bits - there's no
built-in idea of negative numbers. If you want `8'hFF` to mean *-1*
instead of *255*, you say so explicitly with the `signed` keyword:

```systemverilog
logic signed [7:0] temperature;
```

If you're working with a vector that isn't declared `signed` but you
need to compare or use it as a signed value just once, you can cast it
on the spot with `$signed(...)`, without changing its declaration.

## Running the checks

```
svlings run tristate_driver
svlings verify
```

## Exercises in this section

1. `01_tristate_driver.sv` - driving a shared bus, and letting go of it (Z).
2. `02_signed_comparison.sv` - reading a vector as a signed number.
