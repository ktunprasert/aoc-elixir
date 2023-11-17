defmodule AocTest.Y2020.D5 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D5, as: Solver

  @example """
  BFFFBBFRRR
  FFFBBBFRRR
  BBFFBBFRLL
  """

  @fb_pair {0, 127}
  @lr_pair {0, 7}

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 820
    end
  end

  describe "Example helpers" do
    test "decode FB" do
      assert Solver.decode("FBFBBFF" |> String.graphemes(), @fb_pair) == 44
      assert Solver.decode("BFFFBBF" |> String.graphemes(), @fb_pair) == 70
      assert Solver.decode("FFFBBBF" |> String.graphemes(), @fb_pair) == 14
      assert Solver.decode("BBFFBBF" |> String.graphemes(), @fb_pair) == 102
    end

    test "decode LR" do
      assert Solver.decode("RRR" |> String.graphemes(), @lr_pair) == 7
      assert Solver.decode("RLL" |> String.graphemes(), @lr_pair) == 4
    end

    test "decode full" do
      assert Solver.decode("BFFFBBFRRR") == 567
      assert Solver.decode("FFFBBBFRRR") == 119
      assert Solver.decode("BBFFBBFRLL") == 820
    end
  end
end
