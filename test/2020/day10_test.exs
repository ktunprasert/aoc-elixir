defmodule AocTest.Y2020.D10 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D10, as: Solver

  @short_example """
  16
  10
  15
  5
  1
  11
  7
  19
  6
  12
  4
  """

  @long_example """
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@short_example) == 35
      assert Solver.part1(@long_example) == 220
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
