defmodule Aoc.Y2020.D5 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @fb_pair {0, 127}
  @lr_pair {0, 7}
  def part1(input) do
    codes = input |> helper

    codes
    |> Enum.map(&decode/1)
    |> Enum.max()
  end

  def part2(input) do
    :ok
  end

  def decode(code_str) do
    [fb, lr] = code_str |> String.graphemes() |> Enum.chunk_every(7)

    row = decode(fb, @fb_pair)
    col = decode(lr, @lr_pair)

    row * 8 + col
  end

  def decode([c | rest], {min, max} = pair) when c in ["F", "L"] do
    decode(rest, {min, max - distance(pair)})
  end

  def decode([c | rest], {min, max} = pair) when c in ["B", "R"] do
    decode(rest, {min + distance(pair), max})
  end

  def decode(_, {same, same}), do: same

  defp distance({min, max}), do: div(max + 1 - min, 2)

  def helper(input) do
    input |> parse_lines()
  end
end
