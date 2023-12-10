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

  describe "Helper" do
    test "move_rel/3" do
      assert Solver.move_rel({0, 0}, ?|, :s) == {{-1, 0}, :s}
      assert Solver.move_rel({0, 0}, ?|, :n) == {{1, 0}, :n}
      assert Solver.move_rel({0, 0}, ?-, :w) == {{0, 1}, :w}
      assert Solver.move_rel({0, 0}, ?-, :e) == {{0, -1}, :e}
      assert Solver.move_rel({0, 0}, ?L, :n) == {{0, 1}, :w}
      assert Solver.move_rel({0, 0}, ?L, :e) == {{-1, 0}, :s}
      assert Solver.move_rel({0, 0}, ?J, :n) == {{0, -1}, :e}
      assert Solver.move_rel({0, 0}, ?J, :w) == {{-1, 0}, :s}
      assert Solver.move_rel({0, 0}, ?7, :s) == {{0, -1}, :e}
      assert Solver.move_rel({0, 0}, ?7, :w) == {{1, 0}, :n}
      assert Solver.move_rel({0, 0}, ?F, :s) == {{0, 1}, :w}
      assert Solver.move_rel({0, 0}, ?F, :e) == {{1, 0}, :n}
    end
  end
end
