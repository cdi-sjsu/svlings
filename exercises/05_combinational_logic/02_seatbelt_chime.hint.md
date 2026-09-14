```systemverilog
always_comb begin
    if (driving && !seatbelt_on)
        chime = 1'b1;
    else
        chime = 1'b0;
end
```

Every `if` inside `always_comb` needs a matching `else` unless you're
certain every other path already assigns the same variable some other
way. When in doubt, always write the `else`.
