# svlings

Learn SystemVerilog by fixing small, broken circuits, one at a time,
right in your own terminal.

If you've used [Rustlings](https://github.com/rust-lang/rustlings)
before, this is that idea, aimed at hardware description languages
instead of Rust: every exercise is a tiny SystemVerilog design with one
piece missing or wrong. You fix it, a tool tells you immediately whether
you got it right, and you move to the next one. No slides, no lecture
hall - just circuits that are almost right, waiting for you to finish
them.

This course assumes **no prior hardware experience and no prior
programming experience**. If you've never touched a terminal before,
that's fine - there's a short primer for that too, linked below.

## Get started: the commands, right away

If you already have [Nix](https://nixos.org) installed with flakes
enabled, this is the entire setup:

```
git clone <this repository's URL> svling
cd svling
nix develop
svlings list
```

That's it. `nix develop` drops you into a shell with every tool this
course needs already installed and on your PATH - you don't install
anything else yourself, and it won't touch anything outside this
folder. `svlings list` shows you every exercise, in order.

If you have [direnv](https://direnv.net/) set up too, you can skip
typing `nix develop` every time: this repo ships an `.envrc`, so `direnv
allow` once inside the folder gets you the same shell automatically,
every time you `cd` in.

If any of those words - Nix, flakes, terminal, shell - are unfamiliar,
keep reading; the next two sections are for you.

### If you don't have Nix yet

[Nix](https://nixos.org/download) is a package manager that can set up
an exact, reproducible set of tools for a project without installing
anything system-wide or conflicting with software you already have.
Install it with:

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

(macOS and Linux both work; on Windows, use WSL2 first, then run the
same command inside it.) Follow the prompts, then **restart your
terminal** so the changes take effect.

Nix flakes (the specific feature this course's `flake.nix` uses) are
still officially "experimental," so you need to turn them on once:

```
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Then `nix develop` (from inside the `svling` folder) will work as shown
above.

### If you've never used a terminal before

See [`docs/command_line_basics.md`](docs/command_line_basics.md) for a
short primer on what a terminal, a folder, and a text editor are, before
coming back here.

## What you actually do, exercise by exercise

1. Run `svlings verify`. It checks every exercise in order and stops at
   the first one that isn't done yet, explaining what's wrong.
2. Open the file it points you at (something like
   `exercises/02_logic_gates_and_vectors/01_half_adder.sv`) in your
   editor. Every exercise file has a comment at the top explaining the
   idea, and a line marked `TODO` showing exactly what to fill in or
   fix.
3. Make your change, save the file, and run `svlings verify` again (or
   just leave `svlings watch` running in a spare terminal - it reruns
   automatically every time you save).
4. Once it passes, move on. Repeat until `svlings verify` tells you
   every exercise passes.

Since `svlings verify` compiles with verilator from scratch every time,
day-to-day it's fast - it only builds up through wherever you currently
are. Checking the *entire* course in one go (`svlings verify --all`, or
just running `svlings verify` again once you've finished everything)
takes noticeably longer, since it's rebuilding all 32 exercises one
after another. That's normal; use plain `svlings verify` while you work,
and save the full run for a final check.

Stuck? Every exercise has a hint:

```
svlings hint half_adder
```

Still stuck, or just curious what the "right" answer looks like?

```
svlings solution half_adder
```

Nobody's grading you. Looking at the solution and understanding *why*
it works is a completely legitimate way to learn - the goal is
understanding the circuit, not earning the right to see it.

## How the course is organized

```
exercises/    - one numbered folder per section, one concept each
solutions/    - reference answers, same layout, for `svlings solution`
bin/svlings   - the command line tool that runs and checks everything
docs/         - a command-line primer and a verilator reference
flake.nix     - the nix development shell: every tool, pinned and reproducible
```

Sections are numbered and meant to be done in order - each one leans on
ideas from the ones before it. Inside a section, you'll find a
`README.md` explaining the concept in plain language before you touch
any code, plus two or three small exercises putting it into practice.

Each section README opens with two things worth not skipping. **By the
end of this section you can** is the list of what you're actually meant
to walk away able to do - check yourself against it before moving on,
because passing the exercises and understanding them aren't guaranteed
to be the same thing. **Warm-up** is two or three questions about
*earlier* sections. Answer them from memory, out loud or on paper,
before reading the new material. This feels pointless and is not:
pulling something back out of your head is what makes it stick, far
more than re-reading it would.

The support fades on purpose. Through section 14, every exercise hands
you a file with a `TODO` and tells you fairly precisely what to write -
that's how you learn syntax without drowning. Section 15 takes it all
away: a specification, an empty module, and nothing else. That gap is
where "I can read SystemVerilog" turns into "I can write it," and it's
the part you can't skip.

The current lineup (Phase 1 - the language itself):

| # | Section | What it's about |
|---|---------|------------------|
| 00 | welcome | getting the edit/save/check loop working |
| 01 | modules_and_ports | the basic building block of any design |
| 02 | logic_gates_and_vectors | AND/OR/NOT/XOR, bit vectors, literals |
| 03 | data_types | `logic`, 4-state values, signed numbers |
| 04 | operators | arithmetic, logical vs. bitwise, reduction, shifts |
| 05 | combinational_logic | `always_comb`, and the latch pitfall |
| 06 | sequential_logic | `always_ff`, registers, clocks, reset |
| 07 | conditionals_and_case | `case` and `casez` |
| 08 | loops_parameters_generate | `parameter`, procedural `for`, `generate` |
| 09 | arrays_and_memories | unpacked arrays, a tiny RAM |
| 10 | enums_and_structs | named states, grouped signals |
| 11 | functions_and_tasks | reusable combinational logic |
| 12 | finite_state_machines | putting it all together: real FSMs |
| 13 | testbenches_and_verification | writing your own checks and assertions |
| 14 | interfaces_and_whats_next | bundling signals, and where to go next |
| 15 | capstone | no TODOs - a spec, an empty module, and you |

## Verifying your work, the tools behind the scenes

This course uses [Verilator](https://www.veripool.org/verilator/), a
free and extremely fast open-source SystemVerilog simulator, to compile
and run every exercise. `svlings` is just a small wrapper around it;
once you're comfortable, it's worth learning to drive verilator
yourself too - see
[`docs/verilator_cheatsheet.md`](docs/verilator_cheatsheet.md) for the
raw commands, including how to dump and view a waveform with `gtkwave`.

## Why this exists

Most SystemVerilog material out there assumes you already think like an
engineer, or it's a dense reference manual, or it's a university course
you can't just casually start on a Tuesday night. This tries to be
none of those: small steps, instant feedback, plain language, and
genuinely nothing assumed about what you already know - inspired by
Rustlings' bite-sized exercise loop, HDLBits' one-concept-per-problem
structure, and nand2tetris' build-it-yourself philosophy, aimed
squarely at people who've never written a line of code or wired up a
circuit before.

Phase 1 (this repository, today) covers the language itself, thoroughly.
It deliberately leaves out the parts of the SystemVerilog world that are
really about verification *methodology* rather than the language - class-
based testbenches, randomization, functional coverage, UVM. Those are
real and valuable, and they're Phase 2, once you're standing on solid
ground.
