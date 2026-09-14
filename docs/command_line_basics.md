# If you've never used a terminal before

Everything in this course happens in a **terminal** (also called a
shell, console, or command line) - a plain text window where you type
commands instead of clicking things. If you've only ever used a mouse
to run programs, here's the handful of ideas you need before starting.

You already have a terminal on your computer: on Windows it's called
"Terminal" or "PowerShell," on macOS it's "Terminal.app," and on Linux
it's usually just called "Terminal." Open it - you should see a prompt
(something like `$` or `%`) waiting for you to type.

## The one big idea: you're always "in" a folder

Your terminal always has a **current directory** - a folder it's
currently "standing in." Every command you run happens relative to that
folder unless you say otherwise. Four commands cover almost everything
you need:

```
pwd             # "print working directory" - shows where you currently are
ls              # lists what's in the current folder
cd some_folder  # "change directory" - moves into some_folder
cd ..           # moves UP one folder, out of wherever you are
```

So if this course is checked out at, say, `~/svling`, getting into it
looks like:

```
cd ~/svling
ls
```

You'll see the folders described in this README - `exercises/`,
`solutions/`, `bin/`, and so on.

## Editing a file

You need some way to open and edit a text file. Any of these work fine:

- A graphical code editor, like VS Code, Zed, or similar - open the
  `svling` folder in it, and click through to whichever exercise file
  the course points you at.
- A terminal-based editor, if you're comfortable with one - `nano` is
  the friendliest for a first try (`nano exercises/00_welcome/01_hello_gate.sv`,
  then Ctrl+O to save, Ctrl+X to quit).

There's no requirement to use anything fancy. A plain text editor is all
this course ever needs.

## Running a command

Once you're inside the `svling` folder in your terminal, and you've
entered the development shell (see the main README for that one-time
step), you run this course's own command by just typing its name:

```
svlings list
```

If a command errors with something like "command not found," it usually
means you're either not inside the `svling` folder, or you haven't
started the development shell yet - both covered in the main README.

That's genuinely the whole toolkit. Everything else this course asks you
to type is just spelled out for you, step by step, exactly as you should
type it.
