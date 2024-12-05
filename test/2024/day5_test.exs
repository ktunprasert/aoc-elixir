defmodule AocTest.Y2024.D5 do
  use ExUnit.Case, async: true

  alias Aoc.Y2024.D5, as: Solver

  @example """
  29|13
  47|13
  47|29
  47|53
  47|61
  53|13
  53|29
  61|13
  61|29
  61|53
  75|13
  75|29
  75|47
  75|53
  75|61
  97|13
  97|29
  97|47
  97|53
  97|61
  97|75

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 143
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
