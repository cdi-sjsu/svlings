```systemverilog
casez (request)
    4'b1???: grant = 2'd3;
    4'b01??: grant = 2'd2;
    4'b001?: grant = 2'd1;
    4'b0001: grant = 2'd0;
    default: grant = 2'd0;
endcase
```

Each `?` matches either a 0 or a 1 in that position - it means "I'm not
checking this bit."
