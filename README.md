# Advent of Code Elixir

## Getting started

```elixir
iex(1)> Aoc.Y2020.D1.run
Part 1: 926464
Part 2: 65656536
:ok
iex(2)> Aoc.Y2020.D1.run_part1
926464
iex(3)> Aoc.Y2020.D1.run_part2
65656536
```

The repo contains year and day separated modules that has macros to run the solution
dates in `Aoc.Runner`. The parts can be executed directly with `Aoc.Y2020.D1.part1`
or `Aoc.Y2020.D1.part2` though the macros provide an easy way to quickly run given there's
already an input.
