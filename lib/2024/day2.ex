defmodule Aoc.Y2024.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper()
    |> Enum.count(&is_safe?(&1, false))
  end

  def part2(input) do
    input
    |> helper()
    |> Enum.count(&is_safe?(&1, true))
  end

  def is_safe?(lst, can_remove?) do
    a = Enum.at(lst, 0)
    b = Enum.at(lst, -1)

    cond do
      a > b -> is_safe?(lst, -1, can_remove?, :dec)
      a < b -> is_safe?(lst, -1, can_remove?, :inc)
      true -> false
    end
  end

  def is_safe?(lst, _, _, _) when length(lst) < 2, do: true

  def is_safe?([a, b | rest], prev, can_remove?, direction) do
    safe? = is_safe?(a, b, direction)
    dbg {[a, b | rest], prev, can_remove?, direction}

    cond do
      safe? ->
        is_safe?([b | rest], a, can_remove?, direction)

      can_remove? ->
        case rest do
          [c | rest] -> is_safe?(a, c, direction) && is_safe?([c | rest], prev, false, direction)
          [] -> true
        end
      true ->
        false
    end
  end

  def is_safe?(a, a, _), do: false
  def is_safe?(a, b, :inc), do: a < b and b - a <= 3
  def is_safe?(a, b, :dec), do: a > b and a - b <= 3
  def is_safe?(_, _, _), do: false

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(&(String.split(&1) |> Enum.map(fn x -> String.to_integer(x) end)))
  end
end
