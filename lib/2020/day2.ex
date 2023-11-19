defmodule Aoc.Y2020.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    Enum.count(helper(input), fn {{min, max}, char, password} ->
      times = password |> String.to_charlist() |> Enum.count(&(&1 == char))
      times >= min and times <= max
    end)
  end

  def part2(input) do
    Enum.count(helper(input), fn {{min, max}, _char, password} ->
      String.at(password, min - 1) == String.at(password, max - 1)
    end)
  end

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn line ->
      [times, <<char, ":">>, password] = String.split(line, " ")
      [min, max] = times |> String.split("-") |> Enum.map(&String.to_integer/1)

      {{min, max}, char, password}
    end)
  end
end
