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
    |> Enum.reduce(0, fn {{x, _y}, row}, acc ->
      if row |> Enum.at(x) == "#" do
        acc + 1
      else
        acc
      end
    end)
  end

  def part2(input) do
    start = {0, 0}
    grid = input |> helper()
    col_count = grid |> Enum.at(0) |> Enum.count()

    [
      move_gen(col_count, 1, 1),
      move_gen(col_count, 3, 1),
      move_gen(col_count, 5, 1),
      move_gen(col_count, 7, 1),
      move_gen(col_count, 1, 2)
    ]
    |> Enum.map(fn move ->
      coords = Stream.iterate(start, &move.(&1)) |> Enum.take_while(fn {_, y} -> y <= 10 end)

      coords
      |> Enum.map(fn {x, y} -> grid |> Enum.at(y) |> Enum.at(x) end)
      |> Enum.count(fn x -> x == "#" end)
    end)
    |> Enum.reduce(&*/2)
  end

  defp move_gen(n, i, j), do: fn {x, y} -> {(x + i) |> rem(n), y + j} end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.graphemes/1)
  end
end
