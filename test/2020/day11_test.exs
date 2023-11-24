defmodule AocTest.Y2020.D11 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D11, as: Solver

  @example """
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 37
    end

    test "part 2" do
      assert Solver.part2(@example) == 26
    end
  end
end
