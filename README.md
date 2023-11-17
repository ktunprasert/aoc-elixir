# Advent of Code Elixir

## Getting started

### Setting ENV (Optional)

```bash
cp .env.example .env
```

Copy and insert your cookie (required only to download new inputs or running live submission)

### Downloading your inputs

```bash
mix download 2020 1
```

This will download and place your inputs inside the folder required for the computation to run

### Generating the day module and related tests

```bash
mix gen.aoc 2020 5
```

This will set up your day, day test and download your input all in one go

### Runnning computations

```elixir
iex(1)> Aoc.Y2020.D1.run
Part 1: 926464
Part 2: 65656536
:ok
iex(2)> Aoc.Y2020.D1.run 1
926464
iex(3)> Aoc.Y2020.D1.run 2
65656536
```

Equivalent would be

```elixir
iex(1)> Aoc.Runner.run 2020,1,1
926464
iex(2)> Aoc.Runner.run 2020,1,2
65656536
```

If you're too lazy to type I've added `.iex.exs` script to import `Aoc.Runner` which
means you can access `Aoc.Runner.run` without namespacing it

```elixir
iex(1)> run 2020,1,1
926464
iex(2)> run 2020,1,2
65656536
iex(3)> run 2020,1
Part 1: 926464
Part 2: 65656536
:ok
```

The repo contains year and day separated modules that has macros to run the solution
dates in `Aoc.Runner`. The parts can be executed directly with `Aoc.Y2020.D1.part1`
or `Aoc.Y2020.D1.part2` though the macros provide an easy way to quickly run given there's
already an input.
