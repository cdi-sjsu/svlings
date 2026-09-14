Concatenation reads left to right, and the leftmost piece becomes the
most significant bits of the result:

```systemverilog
assign out = {lower_nibble, upper_nibble};
```

That puts `lower_nibble` (in's original bottom half) up top, and
`upper_nibble` (in's original top half) on the bottom - a swap.
