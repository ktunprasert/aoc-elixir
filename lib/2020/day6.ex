defmodule Aoc.Y2020.D6 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    helper(input)
    |> Enum.map(fn group ->
      group
      |> String.graphemes()
      |> Enum.filter(&(&1 != "\n"))
      |> Enum.uniq()
      |> Enum.count()
    end)
    |> Enum.reduce(&+/2)
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines("\n\n")
  end
end
