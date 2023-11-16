defmodule Mix.Tasks.Gen.Aoc do
  use Mix.Task

  @shortdoc "Generates AoC module file for a given year and day."

  def run(args) do
    Mix.Task.run("app.start")

    IO.puts("Beginning generation")

    [year, day] = args
    generate_module_content(year, day) |> write_file("lib/#{year}/day#{day}.ex")
    generate_test_content(year, day) |> write_file("test/#{year}/day#{day}_test.exs")
    generate_input(year, day) |> write_file("priv/inputs/#{year}/day#{day}.txt")

    IO.puts("Done!")
  end

  defp generate_module_content(year, day) do
    """
    defmodule Aoc.Y#{year}.D#{day} do
      use Aoc.Runner, inspect: true

      import Aoc.Util

      def part1(input) do
        :ok
      end

      def part2(input) do
        :ok
      end

      def helper(input) do
        input |> parse_lines()
      end
    end
    """
  end

  defp generate_test_content(year, day) do
    """
    defmodule AocTest.Y#{year}.D#{day} do
      use ExUnit.Case, async: true

      alias Aoc.Y#{year}.D#{day}, as: Solver

      @example ""

      describe "Example case" do
        test "part 1" do
          assert Solver.part1(@example) == :ok
        end

        test "part 2" do
          assert Solver.part2(@example) == :ok
        end
      end
    end
    """
  end

  defp generate_input(year, day) do
    Aoc.Client.get_input(year, day)
  end

  defp write_file(content, path) do
    File.write!(path, content)
    IO.puts("Created file at #{path}")
  end
end
