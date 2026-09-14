# Finite state machines

## By the end of this section you can

- Work out what states a problem actually needs.
- Implement the two-block FSM pattern: a state register plus
  combinational next-state logic.
- Derive an output from the current state.

## Warm-up

This section combines three things you've already built. Answer from
memory before reading on:

1. (§06) Which block type holds a value across clock edges?
2. (§10) How do you give a set of states readable names?
3. (§07) Which statement picks one branch out of many based on a value?

This is the section everything else in this course has been building
toward. A **finite state machine** (FSM) is a circuit that's always in
exactly one of a fixed set of named situations ("states"), and moves
between them based on its inputs.

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
state_e state, state_next;

// Block 1: the state register. This is the ONLY place "state" itself
// ever gets written, and it only changes on a clock edge.
always_ff @(posedge clk) begin
    if (rst)
        state <= STATE_A;
    else if (tick)
        state <= state_next;
end

// Block 2: purely combinational. Given the current state (and maybe
// other inputs), decide what state comes next.
always_comb begin
    case (state)
        STATE_A: state_next = STATE_B;
        STATE_B: state_next = STATE_C;
        STATE_C: state_next = STATE_A;
        default: state_next = STATE_A;
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
svlings run two_process_fsm
svlings verify
```

## Exercises in this section

1. `01_two_process_fsm.sv` - the two-block FSM pattern, built around the
   state transition you designed back in the enums section.
2. `02_sequence_detector.sv` - a small sequence detector.
