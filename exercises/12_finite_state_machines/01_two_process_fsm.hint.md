```systemverilog
case (state)
    STATE_A: state_next = STATE_B;
    STATE_B: state_next = STATE_C;
    STATE_C: state_next = STATE_A;
    default: state_next = STATE_A;
endcase
```

This is exactly the `enum_case` logic from the enums section - the new
part in this exercise is everything wrapped around it (the register and
the `tick` input), not the case statement itself.
