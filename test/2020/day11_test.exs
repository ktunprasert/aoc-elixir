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
      assert Solver.part1(@example) == :ok
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end

  describe "Helper" do
    test "get_adjacent/1" do
      assert Solver.get_adjacent({1,1}) == [
        {0, 0}, {0, 1}, {0, 2},
        {1, 0},         {1, 2},
        {2, 0}, {2, 1}, {2, 2}
      ]
    end

    test "at/2" do
      grid = Solver.helper(@example)

      assert Solver.at(grid, {0, 0}) == "L"
      assert Solver.at(grid, {0, 1}) == "."
      assert Solver.at(grid, {1, 0}) == "L"
      assert Solver.at(grid, {1, 1}) == "L"
    end
  end
end
