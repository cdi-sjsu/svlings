# Finite state machines

This is the section everything else in this course has been building
toward. A **finite state machine** (FSM) is a circuit that's always in
exactly one of a fixed set of named situations ("states"), and moves
between them based on its inputs. A traffic light is one: it's always
either red, green, or yellow, and it moves through those in a fixed
order.

You already have every piece you need:

- an `enum` to name the states (section 10)
- an `always_ff` register to remember which state you're currently in
  (section 6)
- an `always_comb` block with a `case` statement to decide what state
  comes next, and what the outputs should be, based on the current state
  and the inputs (sections 5, 7, and 10)

Putting those together, the standard shape of an FSM is **two** blocks
working together:

```systemverilog
color_e state, state_next;

// Block 1: the state register. This is the ONLY place "state" itself
// ever gets written, and it only changes on a clock edge.
always_ff @(posedge clk) begin
    if (rst)
        state <= RED;
    else if (tick)
        state <= state_next;
end

// Block 2: purely combinational. Given the current state (and maybe
// other inputs), decide what state comes next.
always_comb begin
    case (state)
        RED:     state_next = GREEN;
        GREEN:   state_next = YELLOW;
        YELLOW:  state_next = RED;
        default: state_next = RED;
    endcase
end
```

Splitting it this way - one block that's pure memory, one block that's
pure decision-making - is the pattern almost every real FSM in the world
follows, no matter how complicated. Once you're comfortable with this
shape, you can build far more interesting machines: the second exercise
below has one that watches a stream of bits go by, one per clock, and
notices a specific pattern in them - the first real taste of what a
"sequence detector" looks like, which is a building block for things
like protocol decoders and simple pattern-matching hardware.

## Running the checks

```
svlings run traffic_light_fsm
svlings verify
```

## Exercises in this section

1. `01_traffic_light_fsm.sv` - the two-block FSM pattern, on the light
   you designed the transition logic for back in the enums section.
2. `02_double_one_detector.sv` - a small sequence detector.
