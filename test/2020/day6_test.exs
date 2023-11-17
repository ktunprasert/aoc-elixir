defmodule AocTest.Y2020.D6 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D6, as: Solver

  @example """
  abc

  a
  b
  c

  ab
  ac

  a
  a
  a
  a

  b
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 11
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
