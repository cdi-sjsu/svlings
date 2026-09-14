```systemverilog
case (state)
    RED:     state_next = GREEN;
    GREEN:   state_next = YELLOW;
    YELLOW:  state_next = RED;
    default: state_next = RED;
endcase
```

This is exactly the `next_color` logic from the enums section - the new
part in this exercise is everything wrapped around it (the register and
the `tick` input), not the case statement itself.
