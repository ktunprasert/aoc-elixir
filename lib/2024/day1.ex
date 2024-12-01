defmodule Aoc.Y2024.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper
    |> Enum.with_index()
    |> Enum.split_with(fn {_, index} ->
      rem(index, 2) == 0
    end)
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(fn {{first, _}, {second, _}} ->
      abs(first - second)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input
    |> parse_lines(~r{\s})
    |> Enum.map(&String.to_integer/1)
  end
end
