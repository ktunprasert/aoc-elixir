defmodule AocTest.Y2020.D13 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D13, as: Solver

  @example """
  939
  7,13,x,x,59,x,31,19
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 295
    end

    test "part 2" do
      assert Solver.part2(@example) == 1_068_781
    end
  end
end
