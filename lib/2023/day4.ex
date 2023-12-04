defmodule Aoc.Y2023.D4 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    lines
    |> Enum.reduce(0, fn [winning, playing], acc ->
      sum = case MapSet.intersection(MapSet.new(winning), MapSet.new(playing))
           |> Enum.count() do
        0 -> 0
        n -> 2 ** (n - 1)
      end

      acc + sum
    end)
  end

  def part2(input) do
    :ok
  end

  def parse_num(str), do: parse_num(str, [])
  def parse_num(<<>>, acc), do: Enum.reverse(acc)

  def parse_num(<<?\s, a, ?\s, rest::binary>>, acc) when a in ?0..?9,
    do: parse_num(rest, [a - ?0 | acc])

  def parse_num(<<?\s, a, rest::binary>>, acc) when a in ?0..?9,
    do: parse_num(rest, [a - ?0 | acc])

  def parse_num(<<a, b, ?\s, rest::binary>>, acc),
    do: parse_num(rest, [(a - ?0) * 10 + b - ?0 | acc])

  def parse_num(<<a, b, rest::binary>>, acc) when a in ?0..?9 and b in ?0..?9,
    do: parse_num(rest, [(a - ?0) * 10 + b - ?0 | acc])

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn line ->
      [_, winning, playing] = String.split(line, [": ", " | "], trim: true)

      [winning, playing]
      |> Enum.map(&parse_num/1)
    end)
  end
end
