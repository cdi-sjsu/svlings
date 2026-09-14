# Enums and structs

## Enums: names instead of magic numbers

A traffic light doesn't think of itself as being in "state 2" - it's
just "green." SystemVerilog lets your code say that too, with `typedef
enum`:

```systemverilog
typedef enum logic [1:0] {
    RED,
    GREEN,
    YELLOW
} color_e;
```

This creates a new type, `color_e`, whose only legal values are `RED`,
`GREEN`, and `YELLOW` - which under the hood are just 2-bit numbers (0,
1, 2), but you never have to think about that. You can now declare
signals of this type, compare them, and use them in a `case` statement,
all using the names:

```systemverilog
color_e current, next;

always_comb begin
    case (current)
        RED:    next = GREEN;
        GREEN:  next = YELLOW;
        YELLOW: next = RED;
        default: next = RED;
    endcase
end
```

This is far more readable than tracking "0 means red" in your head (or
in a comment that inevitably goes stale), and it's how you'll represent
states once you get to finite state machines in a couple of sections.

## Structs: grouping related signals

A `struct` bundles several related fields into one named thing, the same
way you might in any general-purpose language:

```systemverilog
typedef struct packed {
    logic [1:0] opcode;
    logic [5:0] operand;
} instruction_t;

instruction_t instr;

assign instr.opcode  = 2'b01;
assign my_operand    = instr.operand;
```

The `packed` keyword means all the fields are laid out contiguously as
one bit vector under the hood (an 8-bit one, here: 2 + 6), so you can
still treat the whole struct as a single vector when you need to - for
example, driving it in one `assign` - while accessing individual pieces
with the `.field` syntax when that's more convenient.

## Running the checks

```
svlings run next_color
svlings verify
```

## Exercises in this section

1. `01_next_color.sv` - an enum and a `case` statement over it.
2. `02_packet_split.sv` - unpacking fields out of a struct.
