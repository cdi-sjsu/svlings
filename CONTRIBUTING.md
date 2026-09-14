# Contributing

svlings is a small, deliberately opinionated course. If you'd like to
add or fix an exercise, here's the shape everything follows.

## Anatomy of one exercise

Every exercise lives in a numbered section folder (`exercises/NN_name/`)
and is exactly four files:

```
exercises/02_logic_gates_and_vectors/01_half_adder.sv        the student edits this
exercises/02_logic_gates_and_vectors/01_half_adder_test.sv   a self-checking testbench
exercises/02_logic_gates_and_vectors/01_half_adder.hint.md   svlings hint half_adder
solutions/02_logic_gates_and_vectors/01_half_adder.sv        svlings solution half_adder
```

The testbench module is always named `tb`, and always ends its
`initial` block the same way:

```systemverilog
if (errors == 0) begin
    $display("SVLINGS: ALL CHECKS PASSED");
    $finish;
end else begin
    $display("SVLINGS: %0d CHECK(S) FAILED", errors);
    $fatal(1);
end
```

`$fatal` gives a nonzero exit code, which is what `svlings` actually
keys off of to decide pass/fail - the `SVLINGS: ...` text is there for
humans reading the output, not for the tool.

## Guidelines

- One concept per exercise. If you're explaining two ideas, it's two
  exercises.
- The starting file should fail in exactly one way: either it doesn't
  compile (a real syntax/structure problem to fix) or it compiles and
  produces a wrong answer (a logic bug to fix) - never a mix of several
  unrelated problems at once.
- Write comments the way you'd explain the idea to a friend who's never
  coded and never seen a circuit. No jargon left unexplained the first
  time it shows up.
- Never start a `//` comment with the word "verilator" (in any casing) -
  Verilator's linter treats that as a special pragma comment, not plain
  text, and will misparse it.
- Before submitting, confirm both ends actually work:
  ```
  svlings run <name>              # should fail, with a sensible message
  cp solutions/.../<name>.sv exercises/.../<name>.sv
  svlings run <name>              # should pass
  # then restore the starting file
  ```

## Running the whole course end to end

```
svlings verify --all
```
