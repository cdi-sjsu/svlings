# Sequential logic and `always_ff`

## By the end of this section you can

- Write an `always_ff @(posedge clk)` block.
- Use nonblocking (`<=`) assignment and say why it's the right one here.
- Implement a synchronous reset.
- Explain what it means for a signal to be a register rather than a wire.

## Warm-up

Answer from memory before reading on:

1. Why does every `if` inside `always_comb` need an `else`?
2. Which assignment operator belongs inside `always_comb`?

Everything so far has been **combinational**: no memory, the output just
reacts to whatever the inputs are right now. Real designs also need
**memory** - a way to remember a value from one moment to the next. That
requires a **clock**.

A clock is just a signal that ticks between 0 and 1 forever, at a steady
rate. The moment it flips from 0 to 1 is called a **rising edge**
(or **posedge**), and it's the heartbeat every sequential circuit
synchronizes to.

```systemverilog
always_ff @(posedge clk) begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end
```

A few new things here:

- `always_ff @(posedge clk)` means "run this block once, right when clk
  rises from 0 to 1, and at no other time." This is how you tell the
  tools "I mean for this to become a real flip-flop / register," as
  opposed to `always_comb`'s "this has no memory."
- Notice the assignment operator: `<=` instead of `=`. This is a
  **nonblocking assignment**, and inside `always_ff` you should always
  use it. (The short version of why: it makes every register in the
  block update "at the same time," using the values everything had
  *before* this clock edge - which matches how real flip-flops behave,
  and avoids a whole category of order-of-statements bugs. You'll get
  the fuller picture with more practice; for now, the rule is simple:
  `<=` in `always_ff`, `=` in `always_comb`.)
- `q` is called a **register** once it's driven this way - it holds its
  value until the next clock edge tells it to change.

## Reset

`rst` above is a **synchronous reset**: it only takes effect on a clock
edge, same as everything else in the block, which keeps the whole design
predictable and is the style you'll use throughout this course. (There's
also *asynchronous* reset, which acts immediately regardless of the
clock - useful in some real designs, but it adds subtlety you don't need
yet.)

## Optional, but do it once: actually look at the clock

Everything above describes signals changing over time, and reading about
that is a poor substitute for seeing it. Once the counter exercise
passes, spend five minutes looking at it as a picture. It is the single
best thing you can do for your intuition about sequential logic, and
almost nobody bothers.

Make a scratch copy so you don't disturb the exercise:

```
mkdir -p /tmp/wave && cd /tmp/wave
cp ~/svling/exercises/06_sequential_logic/02_counter4*.sv .
```

Add these two lines to the very start of the `initial begin` block in
`02_counter4_test.sv` - they tell the simulator to record everything:

```systemverilog
$dumpfile("dump.vcd");
$dumpvars;
```

Then build with `--trace` (which `svlings` doesn't pass, since it
normally doesn't need a recording), run it, and open the result:

```
verilator --binary -sv --timing --trace --top-module tb \
    -Mdir obj -o sim 02_counter4.sv 02_counter4_test.sv
./obj/sim
gtkwave dump.vcd
```

In gtkwave, drag `clk`, `rst`, `enable` and `count` from the panel on
the left into the main view. What you're looking for: `count` never
changes in the middle of anything. It only ever steps at the exact
instant `clk` rises - and it holds perfectly still while `enable` is
low. That picture *is* what "synchronous" means, and once you've seen it
you'll never quite need the words again.

## Running the checks

```
svlings run d_flip_flop
svlings verify
```

## Exercises in this section

1. `01_d_flip_flop.sv` - the simplest possible register.
2. `02_counter4.sv` - a 4-bit counter with reset and an enable input.
