defmodule AocTest.Y2020.D12 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D12, as: Solver

  @example """
  F10
  N3
  F7
  R90
  F11
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 25
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
