defmodule AocTest.Y2020.D2 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D2, as: Solver

  @example """
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 2
    end

    # test "part 2" do
    #   assert D1.part2(@example) == 241_861_950
    # end
  end
end
