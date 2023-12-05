Mix.install([
  {:aoc, path: "."},
  {:benchee, "~> 1.0", only: :dev}
])

Benchee.run(%{
  p1: fn -> Aoc.Runner.run(2023, 3, 1) end,
  p2: fn -> Aoc.Runner.run(2023, 3, 2) end,
})
# IO.inspect(System.argv)
# Aoc.run
