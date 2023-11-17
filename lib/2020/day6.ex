defmodule Aoc.Y2020.D6 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    helper(input)
    |> Enum.reduce(0, fn group, acc ->
      unique =
        group
        |> String.graphemes()
        |> Enum.filter(&(&1 != "\n"))
        |> Enum.uniq()
        |> Enum.count()

      unique + acc
    end)
  end

  def part2(input) do
    helper(input)
    |> Enum.reduce(0, fn group, acc ->
      count = group
      |> String.split("\n")
      |> Enum.map(& &1 |> String.graphemes() |> MapSet.new())
      |> Enum.reduce(&MapSet.intersection/2)
      |> Enum.count()

      acc + count
    end)
  end

  def helper(input) do
    input |> parse_lines("\n\n")
  end
end
