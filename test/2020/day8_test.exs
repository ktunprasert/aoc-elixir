defmodule AocTest.Y2020.D8 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D8, as: Solver

  @example """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 5
    end

    test "part 2" do
      assert Solver.part2(@example) == 8
    end
  end
end
