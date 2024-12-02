defmodule Aoc.Y2024.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper()
    |> Enum.map(&Enum.chunk_every(&1, 2, 1, :discard))
    |> Enum.count(&is_safe?/1)
  end

  def part2(input) do
    :ok
  end

  def is_safe?(lst = [[a, b] | rest]) do
    case {a, b} do
      {a, a} -> false
      {a, b} when a < b and b - a <= 3 -> is_safe?(rest, :inc)
      {a, b} when a > b and a - b <= 3 -> is_safe?(rest, :dec)
      _ -> false
    end
  end

  def is_safe?([], _), do: true
  def is_safe?([[a, a] | _], _), do: false
  def is_safe?([[a, b] | rest], :inc) when a < b and b - a <= 3, do: is_safe?(rest, :inc)
  def is_safe?([[a, b] | rest], :dec) when a > b and a - b <= 3, do: is_safe?(rest, :dec)
  def is_safe?(_, _), do: false

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(&(String.split(&1) |> Enum.map(fn x -> String.to_integer(x) end)))
  end
end
