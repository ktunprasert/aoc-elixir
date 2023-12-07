defmodule Aoc.Y9999.D25 do
  use Aoc.Runner, input: false

  def part1(_input_path), do: :ok
  def part2(_input_path), do: :ok

  def get_input(), do: nil
end

defmodule Aoc.RunnerTest do
  use ExUnit.Case

  # Mock module to use Aoc.Runner
  describe "Aoc.Runner __using__ macro" do
    test "injects run/0 function into the module" do
      assert Aoc.Y9999.D25.run() == :ok
    end
  end

  describe "able to run both parts" do
    test "run(1) and run(2)" do
      assert Aoc.Y9999.D25.run(1) == :ok
      assert Aoc.Y9999.D25.run(2) == :ok
    end
  end

  describe "parse_module_name/1" do
    test "parses module name correctly" do
      assert Aoc.Y9999.D25.parse_module_name("Aoc.Y9999.D25") == [9999, 25]
    end
  end
end
