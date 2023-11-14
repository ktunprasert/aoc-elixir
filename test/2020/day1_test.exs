defmodule AocTest.Y2020.D1 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D1, as: Solver

  @example """
    1721
  979
  366
  299
  675
  1456
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 514_579
    end

    test "part 2" do
      assert Solver.part2(@example) == 241_861_950
    end
  end
end
