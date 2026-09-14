// A shift register takes in one bit at a time and remembers the last
// few of them. It's how a chip talks to the outside world over a single
// wire: bits arrive one per clock tick, and once enough have arrived you
// read them out all at once as a whole byte.
//
// SPECIFICATION
//
//   Inputs:  clk        - the clock
//            rst        - synchronous reset, active high
//            serial_in  - one new bit, arriving per clock tick
//
//   Output:  parallel_out - 8 bits, the last 8 bits that arrived
//
//   On every rising edge of clk:
//     - if rst is high, parallel_out becomes 8'd0
//     - otherwise, everything shifts one position toward the most
//       significant bit, and serial_in becomes the new bit 0.
//
//   So if parallel_out is currently 8'b0000_0011 and serial_in is 1,
//   then after the next clock edge parallel_out is 8'b0000_0111.
//   The old bit 7 falls off the end and is gone.
//
// This one has to remember things between clock ticks, so it's
// sequential.

module shift_register (
    input  logic       clk,
    input  logic       rst,
    input  logic       serial_in,
    output logic [7:0] parallel_out
);

    // Your design goes here.

endmodule
