defmodule AocTest.Y2023.D11 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D11, as: Solver

  @example """
  ...#......
  .......#..
  #.........
  ..........
  ......#...
  .#........
  .........#
  ..........
  .......#..
  #...#.....
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 374
    end

    test "part 2" do
      assert Solver.part2(@example, 10) == 1030
      assert Solver.part2(@example, 100) == 8410
    end
  end
end
