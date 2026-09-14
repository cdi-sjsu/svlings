```systemverilog
assign is_negative = $signed(value) < 0;
```

`$signed(value)` doesn't change `value` itself - it just tells the tools
"for this expression, read these bits as two's complement." The top bit
being 1 is what makes a two's-complement number negative, and `$signed`
handles that interpretation for you.
