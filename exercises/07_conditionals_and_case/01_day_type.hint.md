```systemverilog
case (day)
    3'd0, 3'd6: is_weekend = 1'b1;
    default:    is_weekend = 1'b0;
endcase
```
