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
    parsed =
      {l, r} =
      input
      |> helper
      |> Enum.with_index()
      |> Enum.split_with(fn {_, index} ->
        rem(index, 2) == 0
      end)

    with :part1 <- part do
      parsed
      |> Tuple.to_list()
      |> Enum.map(&Enum.sort/1)
      |> Enum.zip()
      |> Enum.map(fn {{first, _}, {second, _}} ->
        abs(first - second)
      end)
      |> Enum.sum()
    else
      :part2 ->
        count =
          r
          |> Enum.group_by(&elem(&1, 0))
          |> Enum.map(fn {k, v} -> {k, v |> Enum.count()} end)
          |> Enum.into(%{})

        l
        |> Enum.map(fn {v, _} ->
          case count[v] do
            nil -> 0
            counted -> v * counted
          end
        end)
        |> Enum.sum()
    end
  end

  def helper(input) do
    input
    |> parse_lines(~r{\s})
    |> Enum.map(&String.to_integer/1)
  end
end
