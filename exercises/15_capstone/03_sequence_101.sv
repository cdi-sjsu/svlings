// Back in section 12 you finished a detector that noticed two 1s in a
// row - but the states were already named for you, and two of the three
// transitions were already written. This time you get neither.
//
// SPECIFICATION
//
//   Inputs:  clk     - the clock
//            rst     - synchronous reset, active high
//            bit_in  - one new bit of the stream, per clock tick
//
//   Output:  detected - high for exactly one clock cycle each time the
//                       pattern 1, then 0, then 1 has just finished
//                       arriving
//
//   Overlapping patterns count. In the stream 1 0 1 0 1, the pattern
//   appears twice: bits 1-3, and again bits 3-5, sharing that middle
//   1. Both must be detected.
//
//   Timing: "detected" refers to the state the machine is in *after*
//   the clock edge that consumed the final 1. So if the third bit of a
//   pattern is consumed by some clock edge, detected is high for the
//   cycle following that edge, and low again after the next one
//   (unless another pattern completed immediately).
//
//   After reset, the machine has seen nothing.
//
// HOW TO APPROACH THIS
//
//   Don't start by typing. Start by asking: what does the machine need
//   to remember? It can't store the whole stream, and it doesn't need
//   to - all that matters is how much of the pattern has matched so
//   far. Work out how many distinct situations that is, give each one
//   a name, and then work out where each one goes on a 1 and on a 0.
//   That table is your design; writing it in SystemVerilog afterwards
//   is the easy part.
//
//   Watch out for the case that catches everyone: when a partial match
//   breaks, you often aren't back at the beginning. If you've matched
//   "10" and the next bit is 0, you've seen "100" - but that last 0
//   could still be the start of nothing useful, so where does that
//   leave you? And if you've just detected "101" and the next bit is 0,
//   you've now seen "1010" - the last two bits are "10", which is
//   already two-thirds of a fresh pattern. Don't throw that away.

module sequence_101 (
    input  logic clk,
    input  logic rst,
    input  logic bit_in,
    output logic detected
);

    // Your design goes here - including deciding what the states are.

endmodule
