defmodule AocTest.Y2023.D10 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D10, as: Solver

  @example """
  .....
  .S-7.
  .|.|.
  .L-J.
  .....
  """

  @example2 """
  7-F7-
  .FJ|7
  SJLL7
  |F--J
  LJ.LJ
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 4
      assert Solver.part1(@example2) == 8
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
