# Functions and tasks

## By the end of this section you can

- Write an `automatic` function that returns a value, and call it from
  `always_comb`.
- Write a task that reports more than one result through `output` args.
- Say when a function is the right tool and when you need a task.

## Warm-up

Answer from memory before reading on:

1. What does a `typedef enum` buy you over just using 0, 1 and 2?
2. How do you read one field out of a struct?

Once a piece of combinational logic is more than a couple of lines, and
you find yourself wanting to use it in more than one place, it's worth
pulling it out into a **function**:

```systemverilog
function automatic logic [7:0] max2(logic [7:0] a, logic [7:0] b);
    if (a > b)
        return a;
    else
        return b;
endfunction
```

A function takes some inputs, does some computation, and returns a
single value - no clock, no waiting, it all happens instantly (in zero
simulated time), which is why you can call one from inside
`always_comb`:

```systemverilog
always_comb begin
    biggest = max2(x, y);
end
```

The `automatic` keyword tells the tools "give this function its own
fresh set of local variables every time it's called," which matters if
it's ever called from two places "at once," or recursively. It's good
practice to always write `automatic` on functions and tasks in modern
SystemVerilog, so it's worth building the habit now even in simple
cases like this one.

## Tasks: when a function isn't quite enough

A **task** is like a function, but more flexible: it doesn't have to
return exactly one value (it can have several `output` arguments
instead, or none), and - though you won't need this yet - it's also
allowed to model something taking simulated time, which a function
never can.

```systemverilog
task automatic divide(
    input  logic [7:0] dividend,
    input  logic [7:0] divisor,
    output logic [7:0] quotient,
    output logic [7:0] remainder
);
    quotient  = 0;
    remainder = dividend;
    while (remainder >= divisor) begin
        remainder -= divisor;
        quotient++;
    end
endtask
```

As long as a task doesn't contain any actual time-consuming statements
(like the delays you've seen in testbenches), you can call it from
`always_comb` too, exactly like a function.

## Running the checks

```
svlings run max2
svlings verify
```

## Exercises in this section

1. `01_max2.sv` - a small reusable function.
2. `02_divider.sv` - a task with multiple outputs.
