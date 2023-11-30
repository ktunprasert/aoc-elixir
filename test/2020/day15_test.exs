defmodule AocTest.Y2020.D15 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D15, as: Solver

  @example """
  0,3,6
  """

  @example_to_1 "1,3,2"
  @example_to_10 "2,1,3"
  @example_to_27 "1,2,3"
  @example_to_78 "2,3,1"
  @example_to_438 "3,2,1"
  @example_to_1836 "3,1,2"

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 436

      assert Solver.part1(@example_to_1) == 1
      assert Solver.part1(@example_to_10) == 10
      assert Solver.part1(@example_to_27) == 27
      assert Solver.part1(@example_to_78) == 78
      assert Solver.part1(@example_to_438) == 438
      assert Solver.part1(@example_to_1836) == 1836
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
