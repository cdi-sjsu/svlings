# Capstone: build it yourself

Everything up to here handed you a file with a `TODO` in it, and the
comment above the TODO more or less told you what to write. That was on
purpose - it's how you learn syntax without drowning.

This section takes that away.

Each exercise below gives you a **specification** and an empty module.
No TODO telling you which operator to reach for. No half-written block
to complete. You read what the thing is supposed to do, you decide how
to build it, and you build it.

That gap - between "fill in the blank" and "here's what it should do,
go" - is the whole point of this section. It's going to feel harder,
and it's supposed to. If you can do these three, you can write
SystemVerilog. If you can only do the fill-in-the-blank versions, you've
learned to read SystemVerilog, which is a different (and lesser) skill.

## By the end of this section you can

- Read a plain-English spec of a circuit and implement it from an empty
  module, choosing the constructs yourself.
- Combine combinational and sequential logic in one design.
- Design an FSM's states yourself, rather than filling in a transition
  table someone else wrote.

## How to work on these

The testbench is still there, and still tells you exactly which case
failed - that hasn't changed. What's changed is that nothing tells you
*how*. So:

1. Read the spec until you can say out loud what the circuit does.
2. Ask: does this need memory? If it has to remember anything between
   clock ticks, you need `always_ff`. If the output depends only on the
   inputs right now, `always_comb` or `assign` is enough.
3. Sketch the cases on paper before you type. Genuinely - on paper.
   Every experienced designer does this and it is not a beginner crutch.
4. Write it, run it, read the failures, fix it.

`svlings hint <name>` still exists, and it'll nudge you toward the shape
of the answer without writing it for you. Use it after you've been stuck
for a while, not before.

## Exercises in this section

1. `01_alu.sv` - a 4-operation arithmetic/logic unit. Combinational.
2. `02_shift_register.sv` - a serial-in, parallel-out shift register.
   Sequential.
3. `03_sequence_101.sv` - detect the pattern 101 in a bit stream. You
   design the states.
