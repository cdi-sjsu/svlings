```systemverilog
for (int i = 0; i < WIDTH; i++) begin
    if (data[i])
        count = count + 1;
end
```

`data[i]` reads a single bit, just like indexing into any vector. Since
this is inside `always_comb`, use `=` (blocking), not `<=`.
