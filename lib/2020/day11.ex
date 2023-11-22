defmodule Aoc.Y2020.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    grid = helper(input) |> dbg

    :ok
  end

  def part2(input) do
    :ok
  end

  def get_adjacent({x, y}) do
    vector = [-1, 0, 1]

    for i <- vector, j <- vector, {i, j} != {0, 0} do
      {x + i, y + j}
    end
    |> Enum.filter(fn {i, j} -> i >= 0 and j >= 0 end)
  end

  def at(grid, {row, col}), do: grid |> Enum.at(row) |> Enum.at(col)

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.graphemes/1)
  end
end
