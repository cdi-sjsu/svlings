```systemverilog
generate
    for (g = 0; g < WIDTH; g++) begin : gen_inv
        inverter u_inv (.a(in[g]), .y(out[g]));
    end
endgenerate
```

This is exactly like the module instantiation you did back in the
modules-and-ports section - it just happens `WIDTH` times, once for each
value of `g`.
