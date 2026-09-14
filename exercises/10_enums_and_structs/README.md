# Enums and structs

## By the end of this section you can

- Define a `typedef enum` and use its names in a `case`.
- Define a `typedef struct packed` and read its fields with `.field`.
- Follow the `_e` / `_t` naming convention and say what it signals.

## Warm-up

Answer from memory before reading on:

1. Where do the square brackets go for an unpacked array, and where for
   a packed one?
2. Which kind of block do you write a memory's *write* side in?

## Enums: names instead of magic numbers

Code that tracks "state 2" in its head is harder to read than code that
just says "green," or "idle," or whatever that state actually means.
SystemVerilog lets you say that, with `typedef enum`:

```systemverilog
typedef enum logic [1:0] {
    STATE_A,
    STATE_B,
    STATE_C
} state_e;
```

This creates a new type, `state_e`, whose only legal values are
`STATE_A`, `STATE_B`, and `STATE_C` - which under the hood are just
2-bit numbers (0, 1, 2), but you never have to think about that. You can
now declare signals of this type, compare them, and use them in a `case`
statement, all using the names:

```systemverilog
state_e current, next;

always_comb begin
    case (current)
        STATE_A: next = STATE_B;
        STATE_B: next = STATE_C;
        STATE_C: next = STATE_A;
        default: next = STATE_A;
    endcase
end
```

This is far more readable than tracking what each number is supposed to
mean in a comment that inevitably goes stale, and it's how you'll
represent states once you get to finite state machines in a couple of
sections. By convention, an enum's type name ends in `_e` (like
`state_e` above) so it's easy to spot at a glance that it's naming a
fixed set of values rather than an ordinary number.

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
with the `.field` syntax when that's more convenient. By the same
convention as enums, a struct's type name usually ends in `_t` (like
`instruction_t` above) rather than `_e`.

## Running the checks

```
svlings run enum_case
svlings verify
```

## Exercises in this section

1. `01_enum_case.sv` - an enum and a `case` statement over it.
2. `02_struct_fields.sv` - unpacking fields out of a struct.
