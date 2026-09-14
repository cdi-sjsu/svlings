```systemverilog
always_ff @(posedge clk) begin
    if (rst)
        count <= 4'd0;
    else if (enable)
        count <= count + 1;
end
```

Notice `count` refers to its own current value on the right-hand side -
that's completely normal for a register, and it's exactly how you build
a counter: "next value = current value plus one."
