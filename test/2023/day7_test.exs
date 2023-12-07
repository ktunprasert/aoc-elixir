defmodule AocTest.Y2023.D7 do
  use ExUnit.Case, async: true

  alias Aoc.Y2023.D7, as: Solver

  @example """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 6440
    end

    test "part 2" do
      assert Solver.part2(@example) == 5905
    end
  end

  describe "helper" do
    test "determine_kind/1" do
      assert Solver.determine_kind("AAAAA") == :"6_five"
      assert Solver.determine_kind("AA8AA") == :"5_four"
      assert Solver.determine_kind("TTT00") == :"4_full"
      assert Solver.determine_kind("23332") == :"4_full"
      assert Solver.determine_kind("TTT98") == :"3_three"
      assert Solver.determine_kind("TTTAK") == :"3_three"
      assert Solver.determine_kind("TTTQA") == :"3_three"
      assert Solver.determine_kind("23432") == :"2_two"
      assert Solver.determine_kind("A23A4") == :"1_one"
      assert Solver.determine_kind("23456") == :"0_high"
    end
  end
end
