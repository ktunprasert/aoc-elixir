defmodule Aoc.Y2023.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @cubes {12, 13, 14}
  def part1(input) do
    lines = input |> parse_lines()

    start = input |> String.at(5) |> String.to_integer()

    lines
    |> Enum.reduce({start, 0}, fn line, {n, acc} ->
      [_, gamestr] = String.split(line, ": ")

      state =
        gamestr
        |> String.split(";\s")
        |> Enum.reduce_while(:end, fn str, _ ->
          play =
            String.split(str, ",\s")
            |> Enum.reduce({0, 0, 0}, fn str, cube ->
              play_cube(str, cube)
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
    |> Task.async_stream(
      fn line ->
        [_, gamestr] = String.split(line, ": ")

        plays = String.split(gamestr, [";\s", ",\s"])

        plays
        |> Enum.group_by(
          fn
            <<_, ?\s, color::binary>> -> color
            <<_::binary-size(2), ?\s, color::binary>> -> color
          end,
          fn
            <<n, ?\s, _rest::binary>> -> n - ?0
            <<n, m, ?\s, _rest::binary>> -> (n - ?0) * 10 + m - ?0
          end
        )
        |> Enum.reduce(1, fn {_, lst}, acc ->
          acc * Enum.max(lst)
        end)
      end,
      ordered: false
    )
    |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)
  end

  def play_cube(<<i, ?\s, rest::binary>>, {r, g, b}) do
    case rest do
      "red" -> {r + i - ?0, g, b}
      "green" -> {r, g + i - ?0, b}
      "blue" -> {r, g, b + i - ?0}
    end
  end

  def play_cube(<<i, j, ?\s, rest::binary>>, {r, g, b}) do
    num = (i - ?0) * 10 + (j - ?0)

    case rest do
      "red" -> {r + num, g, b}
      "green" -> {r, g + num, b}
      "blue" -> {r, g, b + num}
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
