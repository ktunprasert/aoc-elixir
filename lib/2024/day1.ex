defmodule Aoc.Y2024.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    solve(input, :part1)
  end

  def part2(input) do
    solve(input, :part2)
  end

  def solve(input, part) do
    {l, r} =
      input
      |> helper
      |> split_odd_even()

    with :part1 <- part do
      [l, r]
      |> Enum.map(&Enum.sort/1)
      |> Enum.zip()
      |> Enum.map(fn {l, r} ->
        abs(l - r)
      end)
      |> Enum.sum()
    else
      :part2 ->
        l
        |> Enum.reduce({r |> Enum.frequencies(), 0}, fn n, {map, sum} ->
          case map[n] do
            nil -> {map, sum}
            counted -> {map, sum + n * counted}
          end
        end)
        |> elem(1)
    end
  end

  def split_odd_even(lst), do: split_odd_even(lst, [], [])
  def split_odd_even([], left, right), do: {left, right}

  def split_odd_even([a, b | rest], left, right) do
    split_odd_even(rest, [a | left], [b | right])
  end

  def helper(input) do
    input
    |> parse_lines(~r{\s})
    |> Enum.map(&String.to_integer/1)
  end
end
