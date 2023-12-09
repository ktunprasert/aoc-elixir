defmodule Aoc.Y2023.D9 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper
    |> Enum.reduce(0, fn nums, acc ->
      nums
      |> generate_all_diffs(&List.last/1)
      |> Enum.sum()
      |> Kernel.+(acc)
    end)
  end

  def part2(input) do
    input
    |> helper
    |> Enum.reduce(0, fn nums, acc ->
      nums
      |> generate_all_diffs(&hd/1)
      |> Enum.reduce(&-/2)
      |> Kernel.+(acc)
    end)
    |> Kernel.*(-1)
  end

  def generate_all_diffs(nums, access_fn) do
    nums
    |> Stream.iterate(&generate_diffs/1)
    |> Stream.take_while(&!Enum.all?(&1, fn x -> x == 0 end))
    |> Stream.map(&access_fn.(&1))
  end

  def generate_diffs(lst), do: generate_diffs(lst, [])
  def generate_diffs([a, b | nums], acc), do: generate_diffs([b | nums], [b - a | acc])
  def generate_diffs(_, acc), do: acc |> Enum.reverse()

  def helper(input) do
    input
    |> parse_lines()
    |> Stream.map(&String.split/1)
    |> Stream.map(fn lst -> Enum.map(lst, &String.to_integer/1) end)
  end
end
