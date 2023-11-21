defmodule Aoc.Y2020.D10 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    jolts = helper(input)

    {_, ones, threes} =
      jolts
      |> Enum.reduce({0, 0, 0}, fn jolt, {current, ones, threes} ->
        case jolt - current do
          1 -> {jolt, ones + 1, threes}
          3 -> {jolt, ones, threes + 1}
        end
      end)

    ones * (threes + 1)
  end

  def part2(input) do
    jolts = helper(input)

    last = List.last(jolts)

    jolts
    |> Enum.reduce_while({0, []}, fn jolt, {prev, acc} ->
      if jolt == last do
        {:halt, [jolt - prev | acc]}
      else
        {:cont, {jolt, [jolt - prev | acc]}}
      end
    end)
    |> Enum.chunk_by(&(&1 == 1))
    |> Enum.filter(fn
      [1 | _] = lst -> length(lst) >= 2
      _ -> false
    end)
    |> Enum.reduce(1, fn arr, acc ->
      tribonacci(length(arr) + 1) * acc
    end)
  end

  def tribonacci(n) when n <= 0, do: 0
  def tribonacci(1), do: 1
  def tribonacci(2), do: 1

  def tribonacci(n) do
    tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
  end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.to_integer/1) |> Enum.sort()
  end
end
