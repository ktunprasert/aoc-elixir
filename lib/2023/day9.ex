defmodule Aoc.Y2023.D9 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper
    |> Enum.reduce(0, fn nums, acc ->
      nums
      |> Stream.unfold(fn
        nums ->
          case Enum.all?(nums, & &1 == 0) do
            true -> nil
            _ -> {nums, generate_diffs(nums, [])}
          end
      end)
      |> Stream.map(fn lst -> List.last(lst) end)
      |> Enum.sum()
      |> then(&(&1 + acc))
    end)
  end

  def part2(input) do
    :ok
  end

  def generate_diffs([], acc), do: acc |> Enum.reverse()
  def generate_diffs([_], acc), do: acc |> Enum.reverse()

  def generate_diffs([a, b | nums], acc) do
    generate_diffs([b | nums], [b - a | acc])
  end

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(&(String.split(&1) |> Enum.map(fn x -> String.to_integer(x) end)))
  end
end
