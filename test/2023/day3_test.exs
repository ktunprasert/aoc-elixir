defmodule AocTest.Y2023.D3 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D3, as: Solver

  @example """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """



  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 4361

      assert Solver.part1("#123\n...#") == 123

      assert Solver.part1("...#") == 0
      # 123 -> -1..3 bound | 0..2 real
      assert Solver.part1("123...\n#") == 123
      # 123 -> 2..6 bound | 3..5 real
      assert Solver.part1("..#123...") == 123
      # 123 -> 1..5 bound | 2..4 real
      assert Solver.part1("..123#...") == 123

      assert Solver.part1("12#3") == 15
      assert Solver.part1("123#") == 123
      assert Solver.part1("#123") == 123
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
