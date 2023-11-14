defmodule AocTest.Y2020.D1 do
  use ExUnit.Case

  alias Aoc.Y2020.D1

  @example """
    1721
  979
  366
  299
  675
  1456
  """

  describe "Example case" do
    test "part 1" do
      assert D1.part1(@example) == 514_579
    end

    test "part 2" do
      assert D1.part2(@example) == 241_861_950
    end
  end

  test "Part 1" do
    assert D1.run_part1() == 926_464
  end
end
