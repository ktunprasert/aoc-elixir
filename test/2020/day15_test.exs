defmodule AocTest.Y2020.D15 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D15, as: Solver

  @example """
  0,3,6
  """

  @example2 "1,3,2"
  @example3 "2,1,3"
  @example4 "1,2,3"
  @example5 "2,3,1"
  @example6 "3,2,1"
  @example7 "3,1,2"

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 436

      assert Solver.part1(@example2) == 1
      assert Solver.part1(@example3) == 10
      assert Solver.part1(@example4) == 27
      assert Solver.part1(@example5) == 78
      assert Solver.part1(@example6) == 438
      assert Solver.part1(@example7) == 1836
    end

    test "part 2" do
      # the input is mega long, so we'll omit this
      # assert Solver.part2(@example) == 175594
    end
  end
end
