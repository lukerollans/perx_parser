# Perx Parser Technical Challenge

This is my submission for the Perx Health postfix notation parsing technical
challenge, written in Elixir.

## Installation

The first step is to clone the repo from GitHub

```bash
$ git clone git@github.com:lukerollans/perx_parser.git
$ cd perx_parser
```

The next step is to install Elixir and Erlang/OTP on your machine. You can use
[asdf](https://github.com/asdf-vm/asdf) if you have it installed

```bash
$ cd perx_parser
$ asdf install
```

If you don't, you'll need to follow the [Elixir installation instructions found
here](https://elixir-lang.org/install.html)

Note: Make sure you also install Erlang/OTP, the steps for which are also in the
above link.

Once you have Elixir and Erlang/OTP successfully installed, you can install
the app's dependencies.

Note: There are none except for the standard library, so this step is
essentially just a formality.

```bash
$ mix deps.get
```

Finally, to ensure everything is running nicely, you should run the app's test
suite and ensure it is green

```bash
$ mix test
.........

Finished in 0.04 seconds (0.04s async, 0.00s sync)
9 tests, 0 failures

Randomized with seed 68826
```

## Deliverables

### Invocation instructions

I've set up the deliverable functionality to be invoked via a "mix task". This is
similar to a rake task in a Rails app or a custom script in a Node app.

To invoke it, run the following (while also supplying some CSV data via stdin)

```bash
$ cat sample.csv | mix parse_csv
```

The accompanying `sample.csv` found in this repo can be used as input data as
demonstrated above, however any correctly formatted CSV should work.

### Report

The challenge took me approximately two hours to complete. I chose Elixir not
just because it's one of my favourite languages and one I'm comfortable with,
but primarily because I feel the problem was much easier to solve with a
functional and immutable approach rather than something like Node. This is just
my opinion, I'm sure for other people the opposite may be true!

I approached the problem from a functional point of view. Pulling in each line,
splitting each line up in to cells and printing back out the result of the
postfix notation evaluation in to a new list.

There is one design decision I think can be improved, but it's more of a
performance concern rather than an architectural concern. At the moment, the
entirety of CSV data is loaded in to memory before any processing begins. In
Elixir land, this could easily be updated such that as each line is read in and
concurrently evaluated while subsequent lines are being read. I felt this would
have been a good example of premature optimisation, however.
