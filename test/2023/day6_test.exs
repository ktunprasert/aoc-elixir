defmodule AocTest.Y2023.D6 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D6, as: Solver

  @example """
  Time:      7  15   30
  Distance:  9  40  200
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 288
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
