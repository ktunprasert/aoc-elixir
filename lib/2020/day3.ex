defmodule Aoc.Y2020.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    start = {0, 0}
    grid = input |> helper()
    col_count = grid |> Enum.at(0) |> Enum.count()

    Enum.zip(
      Stream.iterate(start, &move_gen(col_count).(&1)),
      grid
    )
    |> Enum.reduce(0, fn {{x, _y}, row}, acc ->
      if row |> Enum.at(x) == "#" do
        acc + 1
      else
        acc
      end
    end)
  end

  def part2(input) do
    :ok
  end

  defp move_gen(n), do: fn {x, y} -> {(x + 3) |> rem(n), y + 1} end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.graphemes/1)
  end
end
