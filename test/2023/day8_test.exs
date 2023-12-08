defmodule AocTest.Y2023.D8 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D8, as: Solver

  @example """
  RL

  AAA = (BBB, CCC)
  BBB = (DDD, EEE)
  CCC = (ZZZ, GGG)
  DDD = (DDD, DDD)
  EEE = (EEE, EEE)
  GGG = (GGG, GGG)
  ZZZ = (ZZZ, ZZZ)
  """

  @example2 """
  LLR

  AAA = (BBB, BBB)
  BBB = (AAA, ZZZ)
  ZZZ = (ZZZ, ZZZ)
  """

  @example3 """
  LR

  11A = (11B, XXX)
  11B = (XXX, 11Z)
  11Z = (11B, XXX)
  22A = (22B, XXX)
  22B = (22C, 22C)
  22C = (22Z, 22Z)
  22Z = (22B, 22B)
  XXX = (XXX, XXX)
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 2
      assert Solver.part1(@example2) == 6
    end

    test "part 2" do
      assert Solver.part2(@example3) == 6
    end
  end
end
