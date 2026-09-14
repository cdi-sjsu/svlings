Not the answer - just the shape of it.

It's one `always_ff @(posedge clk)` block with a reset branch and an
otherwise branch, exactly like the flip-flop and counter you built in
section 06. The only new part is what goes on the right-hand side of
the otherwise branch.

"Everything shifts up one position, and serial_in becomes the new bit
0" is really "take the bottom 7 bits of what I have now, and stick
serial_in underneath them." You already have both tools for that:

- slicing a range out of a vector (section 02): `parallel_out[6:0]`
- gluing pieces together with concatenation (section 02): `{x, y}`

Put those two together and the whole shift is one expression. Note that
the bottom 7 bits are what survive - bit 7 is the one that falls off.

And since this is `always_ff`, use `<=`, not `=`.
