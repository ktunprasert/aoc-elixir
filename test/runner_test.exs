defmodule Aoc.Y2021.D25 do
  use Aoc.Runner

  def part1(_input_path), do: :ok_part1
  def part2(_input_path), do: :ok_part2
end

defmodule Aoc.RunnerTest do
  use ExUnit.Case

  # Mock module to use Aoc.Runner
  describe "Aoc.Runner __using__ macro" do
    test "injects run/0 function into the module" do
      assert Aoc.Y2021.D25.run() == :ok
    end
  end

  describe "run_part1/0" do
    test "calls part1/1 with input" do
      assert Aoc.Y2021.D25.run_part1() == :ok_part1
    end
  end

  describe "run_part2/0" do
    test "calls part2/1 with input" do
      assert Aoc.Y2021.D25.run_part2() == :ok_part2
    end
  end

  describe "parse_module_name/1" do
    test "parses module name correctly" do
      assert Aoc.Y2021.D25.parse_module_name("Aoc.Y2021.D25") == ["2021", "25"]
    end
  end

  describe "grab_digits/1" do
    test "extracts digits from string" do
      assert Aoc.Y2021.D25.grab_digits("D25") == "25"
    end
  end
end
