# Parameters, loops, and generate blocks

## Parameters: modules with a knob on them

A `parameter` lets a module's width (or really, any constant about it) be
decided by whoever instantiates it, instead of being hardcoded:

```systemverilog
module popcount #(
    parameter WIDTH = 8
) (
    input  logic [WIDTH-1:0] data,
    output logic [3:0]       count
);
```

`WIDTH` defaults to 8, but anyone instantiating this module can override
it:

```systemverilog
popcount #(.WIDTH(4)) small_one (.data(nibble), .count(nibble_count));
```

Same module, different size, no copy-pasting. This is how real designs
stay reusable - you write the counter, the adder, the FIFO once, and
parameterize its width.

## Procedural `for` loops

Inside `always_comb` / `always_ff`, a `for` loop works pretty much like
in any programming language, except it's fully unrolled at build time -
there's no "loop" left over in the actual hardware, it's just a
shorthand for writing out WIDTH copies of the loop body.

```systemverilog
always_comb begin
    count = 4'd0;
    for (int i = 0; i < WIDTH; i++) begin
        if (data[i])
            count = count + 1;
    end
end
```

That's a **population count** ("popcount"): it counts how many bits in
`data` are 1. There's no single operator for that, so a loop is exactly
the right tool.

## Generate blocks: repeating structure, not just statements

A procedural `for` loop repeats *statements*. A `generate for` loop
repeats *hardware structure* - entire module instances - and it needs
its own special loop-counter type, `genvar`, since it only exists at
build time, never in simulation as a real signal:

```systemverilog
genvar g;
generate
    for (g = 0; g < WIDTH; g++) begin : gen_inv
        inverter u_inv (.a(in[g]), .y(out[g]));
    end
endgenerate
```

This stamps out `WIDTH` separate copies of `inverter`, one per bit -
exactly like writing them out by hand, just without actually doing that.
The `: gen_inv` label is required and just names the generated block (so
tools and waveform viewers can refer to `gen_inv[2].u_inv`, for example).

## Running the checks

```
svlings run popcount
svlings verify
```

## Exercises in this section

1. `01_popcount.sv` - a parameterized module with a procedural `for` loop.
2. `02_inverter_array.sv` - a `generate for` loop that instantiates hardware.
