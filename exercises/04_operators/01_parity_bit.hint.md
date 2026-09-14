```systemverilog
assign parity = ^data;
```

That single `^` in front of `data` (with nothing on its left) is
reduction-XOR: it XORs every bit of `data` together into one result,
rather than XORing two separate things.
