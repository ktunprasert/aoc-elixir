defmodule Aoc.Y2023.D2 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @cubes {12, 13, 14}
  def part1(input) do
    start = input |> String.at(5) |> String.to_integer()

    input
    |> parse_lines()
    |> Enum.with_index(start)
    |> Enum.reduce(0, fn {line, n}, acc ->
      line
      |> String.split([": ", "; "])
      |> tl()
      |> Enum.reduce_while(acc + n, fn str, inc ->
        if String.split(str, ",\s") |> Enum.map(&cube/1) |> Enum.any?(&(&1 >>> @cubes)) do
          {:halt, acc}
        else
          {:cont, inc}
        end
      end)
    end)
  end

  def part2(input) do
    input
    |> parse_lines()
    |> Task.async_stream(
      fn line ->
        line
        |> String.split([": ", "; ", ", "])
        |> tl()
        |> Enum.group_by(
          fn
            <<_, ?\s, color::binary>> -> color
            <<_::binary-size(2), ?\s, color::binary>> -> color
          end,
          fn
            <<n, ?\s, _rest::binary>> -> int(n)
            <<n, m, ?\s, _rest::binary>> -> int(n, m)
          end
        )
        |> Enum.reduce(1, fn {_, lst}, acc -> acc * Enum.max(lst) end)
      end,
      ordered: false
    )
    |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)
  end

  def cube(<<i, ?\s, "red">>), do: {int(i), 0, 0}
  def cube(<<i, ?\s, "green">>), do: {0, int(i), 0}
  def cube(<<i, ?\s, "blue">>), do: {0, 0, int(i)}
  def cube(<<i, j, ?\s, "red">>), do: {int(i, j), 0, 0}
  def cube(<<i, j, ?\s, "green">>), do: {0, int(i, j), 0}
  def cube(<<i, j, ?\s, "blue">>), do: {0, 0, int(i, j)}

  def int(i), do: i - ?0
  def int(i, j), do: (i - ?0) * 10 + j - ?0

  def {a, b, c} >>> {x, y, z}, do: a > x || b > y || c > z
end
