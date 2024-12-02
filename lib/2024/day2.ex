defmodule Aoc.Y2024.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper()
    |> Enum.count(&is_safe?(&1))
  end

  def part2(input) do
    input
    |> helper()
    |> Enum.count(fn lst ->
      0..(length(lst) - 1)
      |> Stream.map(&List.delete_at(lst, &1))
      |> Stream.dedup()
      |> Stream.map(fn l -> is_safe?(l) end)
      |> Enum.any?(& &1)
    end)
  end

  def is_safe?(lst) do
    a = Enum.at(lst, 0)
    b = Enum.at(lst, -1)

    cond do
      a > b -> is_safe?(lst, :dec)
      a < b -> is_safe?(lst, :inc)
      true -> false
    end
  end

  def is_safe?(lst, _) when length(lst) < 2, do: true

  def is_safe?([a, b | rest], direction) do
    cmp(a, b, direction) && is_safe?([b | rest], direction)
  end

  def cmp(a, a, _), do: false
  def cmp(a, b, :inc), do: a < b and b - a <= 3
  def cmp(a, b, :dec), do: a > b and a - b <= 3
  def cmp(_, _, _), do: false

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(&(String.split(&1) |> Enum.map(fn x -> String.to_integer(x) end)))
  end
end
