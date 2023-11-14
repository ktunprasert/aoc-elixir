defmodule Aoc.Y2020.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    for [times, <<char, ":">>, password] <- lines |> Enum.map(&String.split(&1, " ")) do
      [min, max] = times |> String.split("-") |> Enum.map(&String.to_integer/1)

      times = password |> String.to_charlist() |> Enum.count(&(&1 == char))

      times >= min and times <= max
    end
    |> Enum.count(& &1)
  end

  def part2(input) do
    lines = helper(input)

    for [times, <<char, ":">>, password] <- lines |> Enum.map(&String.split(&1, " ")) do
      [min, max] = times |> String.split("-") |> Enum.map(&String.to_integer/1)

      chars = password |> String.to_charlist()
      [Enum.at(chars, min - 1), Enum.at(chars, max - 1)] |> Enum.count(&(&1 == char)) == 1
    end
    |> Enum.count(& &1)
  end

  def helper(input) do
    input |> parse_lines()
  end
end
