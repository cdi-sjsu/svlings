The missing band:

```systemverilog
else
    band = 2'd2;
```

The assertion (place it anywhere in the block, right after `band` is
assigned reads best):

```systemverilog
assert (band <= 2'd2) else $error("band out of range: %0d", band);
```
