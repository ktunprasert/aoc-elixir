defmodule AocTest.Y2020.D4 do
  use ExUnit.Case, async: true

  alias Aoc.Y2020.D4, as: Solver

  @example """
  ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  byr:1937 iyr:2017 cid:147 hgt:183cm

  iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  hcl:#cfa07d byr:1929

  hcl:#ae17e1 iyr:2013
  eyr:2024
  ecl:brn pid:760753108 byr:1931
  hgt:179cm

  hcl:#cfa07d eyr:2025 pid:166559648
  iyr:2011 ecl:brn hgt:59in
  """

  describe "Example case" do
    test "part 1" do
      assert Solver.part1(@example) == 2
    end

    test "part 2" do
      assert Solver.part2(@example) == :ok
    end
  end
end
