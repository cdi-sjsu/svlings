# Using verilator directly

`svlings` is a thin wrapper around one tool: [Verilator](https://www.veripool.org/verilator/),
a free, extremely fast, open-source SystemVerilog simulator. Everything
`svlings` does, you can do yourself directly - and once you're working
on something outside this course, verilator (or a tool very like it)
will still be there. This page is a quick reference for using it by
hand.

All of these assume you've entered the course's development shell first
(`nix develop`, from the repository root - see the main README).

## Just check your syntax (fast, no build)

```
verilator --lint-only -Wall my_design.sv
```

This parses and elaborates your design and reports any errors or
warnings, without spending time generating and compiling C++. It's the
fastest way to get feedback while you're still mid-edit, and a good
habit to run often.

## Build and run a simulation

```
verilator --binary -sv --timing -Wall \
    --top-module tb \
    -Mdir obj_dir -o sim \
    my_design.sv my_design_test.sv

./obj_dir/sim
```

What these flags mean:

- `--binary` tells verilator to build a complete, runnable simulation
  executable (as opposed to just generating C++ for you to integrate
  into something else).
- `-sv` turns on SystemVerilog syntax (verilator defaults to
  plain Verilog otherwise).
- `--timing` enables support for delays (`#1`) and event control
  (`@(posedge clk)`) in behavioral code - every testbench in this
  course needs it.
- `-Wall` turns on the full warning set, including ones (like
  `LATCH` and `UNDRIVEN`) that catch real, easy-to-make design bugs.
  By default, verilator treats these warnings as fatal (they stop the
  build) - that's a feature, not a nuisance, while you're learning.
- `--top-module tb` tells verilator which module is the top of the
  design - the one nothing else instantiates. Every testbench in this
  course is named `tb` for exactly this reason.
- `-Mdir obj_dir -o sim` says where to put the generated files, and
  what to name the resulting executable.

## Looking at waveforms

Sometimes `$display` output isn't enough, and you want to see every
signal's value over time, visually. Verilator can record a **waveform**
(a trace file), which you can then open in a viewer:

```
verilator --binary -sv --timing -Wall --trace \
    --top-module tb -Mdir obj_dir -o sim \
    my_design.sv my_design_test.sv

./obj_dir/sim          # this writes out a file, usually dump.vcd
gtkwave dump.vcd
```

`gtkwave` (included in this course's development shell) opens a window
where you can drag signals from the left-hand tree into the main view
and see them drawn as a timeline. Note that recording a trace requires
your testbench to actually ask for one - a simple `$dumpfile("dump.vcd");
$dumpvars;` near the start of your `initial` block is enough. The
testbenches in this course don't do this by default, to keep their
output simple, but nothing stops you from adding it yourself while
you're exploring.

## A note on warnings-as-errors

If you ever want verilator to warn you about something but keep
building anyway (rather than stopping), add `--Wno-fatal`:

```
verilator --binary -sv --timing -Wall --Wno-fatal --top-module tb ...
```

`svlings` deliberately does *not* do this - the whole point of this
course is to make you stop and read what the tool is telling you.

## Other tools worth knowing about

- **yosys** - an open-source synthesis tool. Where verilator simulates
  your design (tells you what it *does*), yosys can turn it into an
  actual gate-level netlist (tells you what it would *become* as real
  hardware). Outside the scope of Phase 1, but worth knowing the name.
- **gtkwave** - covered above; the standard free waveform viewer.
- **surfer** - a newer, browser-based alternative to gtkwave, if you
  prefer that style.
