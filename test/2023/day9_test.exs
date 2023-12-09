defmodule AocTest.Y2023.D9 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D9, as: Solver

  @example """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 114
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
