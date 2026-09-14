Not the answer - the reasoning that gets you there.

Ask what the machine has to remember. Not the stream, just "how much of
101 have I matched so far?" There are only a few answers to that:

- nothing matched yet
- I've just seen a 1 (one third of the way there)
- I've seen 1 then 0 (two thirds)
- I've just completed 101 (this is when detected is high)

That's four situations, so four states. Give them names you'll recognise
at 2am - `SAW_NOTHING`, `SAW_1`, `SAW_10`, `SAW_101` beats `A B C D`.

Now fill in the table - for each state, where do you go on a 1, and
where on a 0? Two of them are the ones the exercise comment warned you
about:

- From "I've seen 1 then 0", a 0 arrives. You've now seen "100". Is any
  part of that the start of a fresh 101? No - so you're back to nothing.
- From "I've seen 1 then 0", a 1 arrives - that completes the pattern.
- From "just completed 101", a 0 arrives. The stream ends "...1010".
  Look at the last two bits: "10". You are *already* two thirds of the
  way into the next pattern. Going back to the start here is the single
  most common way to get this wrong, and it's what makes the
  overlapping detection at bit 5 fail.
- From "I've just seen a 1", another 1 arrives. You've seen "11" - the
  first 1 is useless now, but the second one is still a valid start, so
  you stay where you are rather than going backwards.

The structure itself is the two-block pattern from section 12, unchanged:
an `always_ff` holding the state with a reset branch, an `always_comb`
with a `case` deciding the next one, and `detected` derived from which
state you're in.
