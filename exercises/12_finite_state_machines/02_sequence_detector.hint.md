```systemverilog
case (state)
    S0: state_next = bit_in ? S1 : S0;
    S1: state_next = bit_in ? S2 : S0;
    S2: state_next = bit_in ? S2 : S0;
    default: state_next = S0;
endcase
```

Notice S1 and S2 actually have the same rule here: "a 1 goes to S2, a 0
goes back to S0." That's fine - FSM transition tables often do repeat
like this, it's just what the pattern happens to need.
