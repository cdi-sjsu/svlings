The DUT computes the absolute difference: whichever number is bigger,
minus the smaller one. `|2 - 15|` is `15 - 2`, which is `13`:

```systemverilog
a = 4'd2; b = 4'd15; #1; check(4'd13, "2 and 15");
```
