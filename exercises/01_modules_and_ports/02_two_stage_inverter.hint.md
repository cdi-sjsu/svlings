Copy the `stage0` instance, rename it to `stage1`, and change the
connections so it reads from `mid` and writes to `out`:

```systemverilog
inverter stage1 (
    .a (mid),
    .y (out)
);
```

Instance names (`stage0`, `stage1`) just need to be unique within the
module - they don't have to mean anything special, they're just labels
for each copy.
