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

    device_jolt = Enum.max(jolts) + 3
    jolts = [0 | jolts] ++ [device_jolt]

    {_, {_, jolt_dist_chunks}} =
      jolts
      |> Enum.map_reduce(
        {0, [[]]},
        fn x, {acc, [lst | rest]} ->
          case x - acc do
            1 -> {x - acc, {x, [[x - acc | lst] | rest]}}
            _ -> {x - acc, {x, [[], lst | rest]}}
          end
        end
      )

    jolt_dist_chunks
    |> Enum.filter(&length(&1) >= 2)
    |> Enum.reduce(1, fn arr, acc ->
      tribonacci(length(arr)) * acc
    end)
  end

  def tribonacci(n) do
    [1, 2, 4, 7, 13] |> Enum.at(n - 1)
  end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.to_integer/1) |> Enum.sort()
  end
end
