defmodule AocTest.Y2023.D1 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D1, as: Solver

  @example """
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  """

  @example2 """
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 142
    end

    test "part 2" do
      assert Solver.part2(@example2) == 281
    end
  end
end
