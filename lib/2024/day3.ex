defmodule Aoc.Y2024.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    solve(input, :part1)
  end

  def part2(input) do
    :ok
  end

  def solve(input, part) do
    re = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    case part do
      :part1 ->
        Regex.scan(re, input)
        |> Enum.map(&tl/1)
        |> Enum.map(fn lst -> lst |> Enum.map(&String.to_integer/1) |> Enum.product() end)
        |> Enum.sum()
    end
  end

  def helper(input) do
    input
  end
end
