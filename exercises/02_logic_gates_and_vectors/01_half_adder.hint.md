`sum` should be 1 when exactly one of `a`, `b` is 1 - that's the XOR
gate, written `^`:

```systemverilog
assign sum = a ^ b;
```

`carry` should be 1 only when both `a` and `b` are 1 - that's AND,
written `&`:

```systemverilog
assign carry = a & b;
```
