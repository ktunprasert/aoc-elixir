defmodule AocTest.Y2023.D5 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D5, as: Solver

  @example """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 35
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
