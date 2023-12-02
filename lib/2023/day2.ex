defmodule Aoc.Y2023.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @cubes {12, 13, 14}
  def part1(input) do
    lines = input |> parse_lines()

    lines
    |> Enum.reduce({1, 0}, fn line, {n, acc} ->
      [_, gamestr] = String.split(line, ": ")

      state =
        gamestr
        |> String.split(";\s")
        |> Enum.reduce_while(:end, fn str, _ ->
          play =
            String.split(str, ",\s")
            |> Enum.reduce({0, 0, 0}, fn str, cube ->
              play_cube(cube, str)
            end)

          cond do
            play >>> @cubes -> {:halt, :end}
            true -> {:cont, :found}
          end
        end)

      case state do
        :end -> {n + 1, acc}
        _ -> {n + 1, acc + n}
      end
    end)
    |> elem(1)
  end

  def part2(input) do
    input
    |> parse_lines()
    |> Enum.reduce(0, fn line, acc ->
      [_, gamestr] = String.split(line, ": ")

      prod =
        gamestr
        |> String.split(";\s")
        |> Enum.reduce({0, 0, 0}, fn str, cube ->
          new_cube =
            String.split(str, ",\s")
            |> Enum.reduce({0, 0, 0}, fn str, cube ->
              play_cube(cube, str)
            end)

          cube <~> new_cube
        end)
        |> Tuple.product()

      acc + prod
    end)
  end

  def play_cube({r, g, b}, str) do
    case Integer.parse(str) do
      {n, " red"} -> {r + n, g, b}
      {n, " green"} -> {r, g + n, b}
      {n, " blue"} -> {r, g, b + n}
    end
  end

  def {a, b, c} <~> {x, y, z} do
    {max(a, x), max(b, y), max(c, z)}
  end

  def {a, b, c} >>> {x, y, z} do
    a > x || b > y || c > z
  end

  def helper(input) do
    input |> parse_lines()
  end
end
