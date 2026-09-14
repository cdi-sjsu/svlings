```systemverilog
while (remainder >= divisor) begin
    remainder -= divisor;
    quotient++;
end
```

`-=` and `++` work here the same way they would in most other languages
you may have brushed up against: `remainder -= divisor` is short for
`remainder = remainder - divisor`, and `quotient++` is short for
`quotient = quotient + 1`.
