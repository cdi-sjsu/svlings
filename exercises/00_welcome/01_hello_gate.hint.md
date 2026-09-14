Somewhere in `01_hello_gate.sv` there's a line that starts with `//`,
which makes SystemVerilog treat the whole rest of that line as a comment -
it's invisible to the tools, purely a note to a human reader.

Delete just the `//` (and the single space right after it) from the front
of that line, so it becomes real code instead of a note about code.

Save the file, then run `svlings verify` again.
