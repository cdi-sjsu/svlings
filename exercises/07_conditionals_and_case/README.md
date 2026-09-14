# Conditionals and `case`

You've already used `if`/`else` chains quite a bit. Once you're choosing
between more than two or three options, a chain of `if`/`else if` gets
hard to read - that's what `case` is for:

```systemverilog
always_comb begin
    case (sel)
        3'd0, 3'd6: hit = 1'b1;   // matches either value
        default:    hit = 1'b0;
    endcase
end
```

A `case` statement checks its input against each listed value in order,
top to bottom, and runs the first branch that matches. You can list
several values for the same branch separated by commas, like the line
above matching `3'd0` or `3'd6`. `default` catches everything that
didn't match anything listed - and just like `if`/`else` in a
combinational block, you almost always want one, so every path assigns
a value.

## Don't-care bits with `casez`

Sometimes you don't care about every bit of the thing you're comparing -
only some of them. `casez` lets you write `?` in a case item to mean
"this bit can be anything":

```systemverilog
casez (request)
    4'b1???: grant = 2'd3;  // bit 3 set - top priority, ignore the rest
    4'b01??: grant = 2'd2;
    4'b001?: grant = 2'd1;
    4'b0001: grant = 2'd0;
    default: grant = 2'd0;
endcase
```

This checks branches top-to-bottom just like a regular `case`, so the
*first* matching pattern wins - which is exactly how you'd build a
**priority encoder**: something that looks at several request lines and
answers "which one, out of possibly several that are active, should win?"

## Running the checks

```
svlings run grouped_case_items
svlings verify
```

## Exercises in this section

1. `01_grouped_case_items.sv` - a plain `case` statement.
2. `02_priority_encoder.sv` - `casez` and don't-care bits.
