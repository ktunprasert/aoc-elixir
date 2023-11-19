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
    :ok
  end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.to_integer/1) |> Enum.sort()
  end
end
