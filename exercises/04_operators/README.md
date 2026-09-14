# Operators

You've already used a handful of operators without a formal introduction.
Here's the rest of the everyday toolkit.

## Arithmetic and relational

These work about the way you'd expect coming from any calculator:
`+ - * / %` for arithmetic, and `< > <= >= == !=` for comparisons that
produce a single 1-bit true/false result.

## Logical vs. bitwise - a real gotcha

SystemVerilog has two AND operators, two OR operators, and two NOT
operators, and mixing them up is one of the most common beginner
mistakes:

| operator     | kind     | operates on                          |
|--------------|----------|----------------------------------------|
| `&` `\|` `~` | bitwise  | every bit of a vector, independently    |
| `&&` `\|\|` `!` | logical | the whole value as one true/false thing |

`~4'b1100` flips every bit, giving `4'b0011`. `!4'b1100` asks "is this
value zero?" - it isn't, so the answer is just `1'b0` (false). Bitwise
operators are for manipulating bit patterns; logical operators are for
combining true/false conditions, the same way you'd combine two
comparisons: `if (a > 0 && b > 0)`.

## Reduction operators

Put one of the bitwise operators in front of a whole vector (instead of
between two things) and it becomes a **reduction operator** - it folds
every bit of the vector down to a single bit.

```systemverilog
logic [7:0] data;
logic       any_bit_set;
logic       all_bits_set;
logic       parity;

assign any_bit_set  = |data;   // OR every bit together
assign all_bits_set = &data;   // AND every bit together
assign parity       = ^data;   // XOR every bit together
```

That last one, reduction XOR, is exactly how a **parity bit** is
computed: it comes out 1 if an odd number of bits in `data` are set.
Parity bits are a very old, very simple way to detect if a byte got
corrupted in transit.

## Shifting

`<<` and `>>` shift a vector's bits left or right, filling the vacated
side with 0s - handy for cheap multiplication/division by powers of two,
among other things.

```systemverilog
assign doubled = value << 1;  // same as value * 2
```

## Running the checks

```
svlings run parity_bit
svlings verify
```

## Exercises in this section

1. `01_parity_bit.sv` - reduction XOR.
2. `02_volume_boost.sv` - shifting and the ternary operator together.
