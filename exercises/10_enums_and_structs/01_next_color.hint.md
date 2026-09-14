```systemverilog
case (current)
    RED:     next = GREEN;
    GREEN:   next = YELLOW;
    YELLOW:  next = RED;
    default: next = RED;
endcase
```
