defmodule AocTest.Y2020.D14 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D14, as: Solver

  @example """
  mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  mem[8] = 11
  mem[7] = 101
  mem[8] = 0
  """

  @example_v2 """
  mask = 000000000000000000000000000000X1001X
  mem[42] = 100
  mask = 00000000000000000000000000000000X0XX
  mem[26] = 1
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 165
    end

    test "part 2" do
      assert Solver.part2(@example_v2) == 208
    end
  end

  describe "Helpers" do
    test "parse_mem/1" do
      assert Solver.parse("mem[8] = 11") == {:mem, 8, 11}
      assert Solver.parse("mask = XX0") == {:mask, "XX0"}
    end

    test "mask/2" do
      assert Solver.mask("0000", "1101", []) == ~c"0000"
      assert Solver.mask("1111", "0000", []) == ~c"1111"
    end
  end
end
