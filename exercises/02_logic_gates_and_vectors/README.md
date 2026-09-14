# Logic gates and vectors

Every digital circuit, no matter how complicated, is ultimately built out
of a small handful of gates. If you've never seen these before, here's
the whole list you actually need to start:

| operator | name | meaning                              |
|----------|------|---------------------------------------|
| `&`      | AND  | 1 only if both inputs are 1           |
| `\|`     | OR   | 1 if either input is 1                |
| `~`      | NOT  | flips a 1 to a 0 and a 0 to a 1       |
| `^`      | XOR  | 1 if the inputs are *different*       |

You combine these the same way you'd combine `+` and `*` in arithmetic:

```systemverilog
assign sum   = a ^ b;   // XOR
assign carry = a & b;   // AND
```

That's a real circuit, by the way - it's called a **half adder**, and
it's the first exercise below.

## Vectors: more than one wire at a time

A single wire (`logic`) can only hold a 0 or a 1. Most of the time you
want a group of wires that act as one number, like an 8-bit byte. That's
a **vector**:

```systemverilog
logic [7:0] byte_value;   // 8 wires, indexed 7 down to 0
```

`[7:0]` means "bit 7 down to bit 0," which is 8 bits total. Bit 0 is the
least significant (right-most, worth 1), bit 7 is the most significant
(left-most, worth 128). You can grab a single bit or a range with the
same square-bracket syntax: `byte_value[0]`, `byte_value[3:0]` (the
bottom nibble).

Number literals in SystemVerilog carry their size and base along with
them: `4'b1010` is a 4-bit binary number, `8'hFF` is an 8-bit hex number
(255), `3'd5` is a 3-bit decimal 5. Get comfortable reading these, you'll
see them everywhere.

## Gluing vectors together: concatenation

The curly-brace operator `{ , }` glues bits and vectors together into a
wider vector, left to right:

```systemverilog
logic [3:0] upper, lower;
logic [7:0] whole;

assign whole = {upper, lower}; // upper becomes the top 4 bits
```

`{3{1'b0}}` is *replication* - it repeats `1'b0` three times, giving you
`3'b000`. Handy for building constants of a certain width without typing
every bit.

## Running the checks

```
svlings run half_adder
svlings verify
```

## Exercises in this section

1. `01_half_adder.sv` - your first real circuit: adding two single bits.
2. `02_nibble_swap.sv` - rearranging an 8-bit vector with concatenation.
