The ternary operator `cond ? a : b` picks `a` when `cond` is true and `b`
otherwise - you've used it implicitly in earlier sections' testbenches,
now it's your turn:

```systemverilog
assign bus = enable ? data : 8'bz;
```

`8'bz` means "8 bits, binary, and the digit is Z" - SystemVerilog spreads
that single `z` across all 8 bits for you.
