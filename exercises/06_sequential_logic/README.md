# Sequential logic and `always_ff`

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

## Running the checks

```
svlings run d_flip_flop
svlings verify
```

## Exercises in this section

1. `01_d_flip_flop.sv` - the simplest possible register.
2. `02_counter4.sv` - a 4-bit counter with reset and an enable input.
