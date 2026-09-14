Not the answer - just the shape of it.

Two outputs, and they're different in kind. `result` depends on which
`op` you were handed, so that's a four-way choice: a `case` statement
on `op` inside `always_comb` is the natural fit (you did exactly this
in the conditionals section, just with fewer branches).

`zero` doesn't depend on `op` at all. It only depends on what `result`
came out as. So you can compute `result` first, then derive `zero` from
it - either with a separate `assign`, or as a line in the same
`always_comb` after the case finishes.

For `zero` itself: you want "is every bit of result a 0?". You could
compare against `8'd0`. There's also a reduction operator from section
04 that folds a whole vector into one bit and gets you there in one
character - both are correct, pick whichever you find clearer.

Remember the rule from section 05: inside `always_comb`, every output
must get assigned on every path. A `default:` branch in your case is
the easy way to guarantee that.
