# Arrays and memories

You already know one kind of array without calling it that: a vector
like `logic [7:0] byte_value` is really an array of 8 individual bits.
That's called a **packed** array - all its bits are treated as one
contiguous chunk, which is why you can do arithmetic on the whole thing
at once.

An **unpacked** array is a list of separate elements, written with the
brackets *after* the name instead of before it:

```systemverilog
logic [7:0] mem [0:3];   // 4 separate 8-bit elements: mem[0] .. mem[3]
```

That one line just built a tiny 4-entry memory. Each element (`mem[0]`,
`mem[1]`, ...) is an 8-bit vector, and you index into the array the same
way you'd index into a single vector's bits: `mem[addr]`.

You can give one an initial value with an array literal:

```systemverilog
logic [7:0] mem [0:3] = '{8'd10, 8'd20, 8'd30, 8'd40};
```

## Reading and writing

Reading from an array is just like reading any variable - `value = mem[addr];`
works fine inside `always_comb`. Writing is usually done inside
`always_ff`, on a clock edge, the same way you'd update any register:

```systemverilog
always_ff @(posedge clk) begin
    if (we)
        mem[addr] <= din;
end
```

This pattern - an array, written synchronously, read out either
combinationally or synchronously - is the backbone of every real memory
you'll ever instantiate: register files, caches, FIFOs, all of it.

## Running the checks

```
svlings run lookup_table
svlings verify
```

## Exercises in this section

1. `01_lookup_table.sv` - reading from a small, pre-filled array.
2. `02_simple_ram.sv` - writing to an array on a clock edge.
