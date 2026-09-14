# Combinational logic and `always_comb`

`assign` is great for a single expression, but real logic often needs
`if`/`else` or multiple steps, and `assign` can't do that on its own.
For that, SystemVerilog gives you the `always_comb` block:

```systemverilog
always_comb begin
    if (sel)
        y = b;
    else
        y = a;
end
```

"Combinational" means the output depends only on the *current* inputs -
there's no memory involved, no clock, nothing about the past. If any
input changes, the output re-settles immediately (well, after a tiny bit
of real-world delay, but conceptually: instantly). `always_comb`
automatically re-runs the block whenever any input it reads changes, so
you never have to write a sensitivity list yourself.

Inside `always_comb` (and other procedural blocks you'll meet soon),
assignment uses a single `=`, called a **blocking assignment**. Later,
when you meet sequential logic, you'll see a different assignment
operator, `<=`, and the distinction between the two matters a lot - but
for now, inside `always_comb`, always use `=`.

## The one rule you cannot break: assign every output, every path

Here's the rule that trips up almost everyone at least once: every
output your `always_comb` block touches must be assigned a value on
*every possible path* through the block - including any implicit "do
nothing" path, like an `if` with no matching `else`.

If you forget, the tools assume you meant "keep whatever value this had
before" - which requires memory, which is exactly what combinational
logic isn't supposed to have. The result is called an accidentally
inferred **latch**, and it's a real (and famous) source of hardware
bugs. Verilator will warn you about it loudly, and that warning is worth
taking seriously every single time.

## Running the checks

```
svlings run mux2to1
svlings verify
```

## Exercises in this section

1. `01_mux2to1.sv` - your first `always_comb` block, a 2-to-1 selector.
2. `02_inferred_latch.sv` - find and fix an accidentally inferred latch.
