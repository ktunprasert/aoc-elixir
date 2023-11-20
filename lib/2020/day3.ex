defmodule Aoc.Y2020.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    start = {0, 0}
    grid = input |> helper()
    col_count = grid |> Enum.at(0) |> Enum.count()

    Enum.zip(
      Stream.iterate(start, &move_gen(col_count, 3, 1).(&1)),
      grid
    )
    |> Enum.count(fn {{x, _}, row} -> row |> Enum.at(x) == "#" end)
  end

  def part2(input) do
    start = {0, 0}
    grid = input |> helper()
    col_count = grid |> Enum.at(0) |> length
    row_count = grid |> length

    [
      move_gen(col_count, 1, 1),
      move_gen(col_count, 3, 1),
      move_gen(col_count, 5, 1),
      move_gen(col_count, 7, 1),
      move_gen(col_count, 1, 2)
    ]
    |> Enum.reduce(1, fn move, acc ->
      trees =
        Stream.iterate(start, &move.(&1))
        |> Enum.take_while(fn {_, y} -> y < row_count end)
        |> Enum.count(fn {x, y} -> grid |> Enum.at(y) |> Enum.at(x) == "#" end)

      acc * trees
    end)
  end

  defp move_gen(n, i, j), do: fn {x, y} -> {(x + i) |> rem(n), y + j} end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.graphemes/1)
  end
end
