defmodule AocTest.Y2023.D2 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D2, as: Solver

  @example """
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 8
    end

    test "part 2" do
      assert Solver.part2(@example) == 2286
    end
  end
end
