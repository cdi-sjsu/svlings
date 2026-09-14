```systemverilog
case (current)
    STATE_A: next = STATE_B;
    STATE_B: next = STATE_C;
    STATE_C: next = STATE_A;
    default: next = STATE_A;
endcase
```
