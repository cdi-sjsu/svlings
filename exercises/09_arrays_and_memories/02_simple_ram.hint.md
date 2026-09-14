```systemverilog
always_ff @(posedge clk) begin
    if (we)
        mem[addr] <= din;
end
```
