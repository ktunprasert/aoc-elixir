defmodule AocTest.Y2020.D9 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D9, as: Solver

  @example """
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example, 5) == 127
    end

    test "part 2" do
      assert Solver.part2(@example, 5) == 62
    end
  end
end
