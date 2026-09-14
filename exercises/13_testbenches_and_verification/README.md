# Writing your own checks

Every exercise so far has come with a testbench already written for you.
This section is about writing your own - because in real work, nobody
hands you one. You write the circuit, and then you write something that
proves it does what you claim.

You already know most of the pieces:

- `$display("...", args)` prints a message, with `%b` / `%0d` / `%h` /
  `%s` etc. standing in for values, the way `printf` works in a lot of
  languages. `$monitor(...)` is similar but re-prints automatically
  every time one of its arguments changes - handy for a running log
  instead of one-off prints.
- driving inputs, waiting with `#1` or `@(posedge clk)`, then checking
  outputs - the exact loop every testbench in this course has used.

## Assertions: writing the check as part of the design

An **immediate assertion** lets you state an invariant right where it
matters, instead of only checking it from the outside in a testbench:

```systemverilog
assert (fan_speed <= 2'd2) else $error("fan_speed out of range: %0d", fan_speed);
```

If the condition is true, nothing happens - simulation continues
silently. If it's false, the `else` branch runs, which is normally where
you'd print a `$error` (reports a problem, keeps simulating) or `$fatal`
(reports a problem, stops simulating immediately - you've seen `$fatal`
used at the end of every testbench in this course). Sprinkling
assertions through your own designs, right next to the invariant they're
protecting, is one of the highest-value habits in this whole course:
they catch bugs the moment they happen, not several stages later when
you're trying to figure out where a wrong value came from.

## Going beyond svlings: using verilator directly

Everything in this course runs through the `svlings` command, but it's
just a thin wrapper - the actual tool is `verilator`, and it's worth
knowing how to reach for it yourself:

```
# Just check your syntax and wiring, without building or running anything.
# This is the fastest way to get feedback while you're mid-edit.
verilator --lint-only -Wall my_design.sv

# Build and run a design + testbench together (this is what svlings does
# for you under the hood).
verilator --binary -sv --timing -Wall --top-module tb my_design.sv my_design_test.sv -Mdir obj_dir -o sim
./obj_dir/sim

# Record a waveform (a trace of every signal over time) so you can look
# at it visually instead of only reading $display output.
verilator --binary -sv --timing -Wall --trace --top-module tb my_design.sv my_design_test.sv -Mdir obj_dir -o sim
./obj_dir/sim         # this produces a file called dump.vcd (or similar)
gtkwave dump.vcd      # opens a waveform viewer - drag signals in from the left
```

There's a full reference in `docs/verilator_cheatsheet.md` at the root
of this course, with more flags and a few debugging tips.

## A different kind of exercise

In `01_write_a_checker.sv`, the roles are flipped: the file you edit
*is* the testbench, and the file you don't edit contains a small,
already-correct circuit. Read the comment at the top of that file
carefully before diving in - it explains what's going on.

## Running the checks

```
svlings run write_a_checker
svlings verify
```

## Exercises in this section

1. `01_write_a_checker.sv` - fix a broken check against a correct circuit.
2. `02_temperature_to_fan.sv` - finish a design that includes an assertion.
