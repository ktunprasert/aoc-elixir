defmodule AocTest.Y2024.D2 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D2, as: Solver

  @example """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 2
    end

    test "part 2" do
      assert Solver.part2(@example) == 4
    end

    test "part 2: double dupes" do
      assert Solver.part2("1 1 1 1 1") == 0
      assert Solver.part2("2 2 3 3 4") == 0

      assert Solver.part2("1 2 2 3 4") == 1
      assert Solver.part2("1 2 3 4 4") == 1
      assert Solver.part2("1 1 2 3 4") == 1

      assert Solver.part2("1 2 7 3 4") == 1
    end
  end
end
