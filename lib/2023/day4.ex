defmodule Aoc.Y2023.D4 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    lines
    |> Enum.reduce(0, fn [winning, playing], acc ->
      sum =
        case MapSet.intersection(MapSet.new(winning), MapSet.new(playing))
             |> Enum.count() do
          0 -> 0
          n -> 2 ** (n - 1)
        end

      acc + sum
    end)
  end

  def part2(input) do
    input
    |> helper()
    |> Enum.reduce({1, %{}}, fn [winning, playing], {card_n, map} ->
      matches = Enum.count(MapSet.intersection(MapSet.new(winning), MapSet.new(playing)))

      map = Map.update(map, card_n, 1, fn x -> x + 1 end)

      if matches == 0 do
        {card_n + 1, map}
      else
        copies = Map.get(map, card_n)

        map =
          (card_n + 1)..(card_n + matches)
          |> Enum.reduce(map, fn n, map ->
            Map.update(map, n, copies, fn x -> x + copies end)
          end)

        {card_n + 1, map}
      end
      |> IO.inspect(label: "card #{card_n} matches #{matches}")

    end)
    |> elem(1)
    |> Enum.reduce(0, fn {_, copies}, acc -> acc + copies end)
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
      [_card, winning, playing] = String.split(line, [": ", " | "], trim: true)

      [winning, playing] =
        [winning, playing]
        |> Enum.map(&parse_num/1)

      # n = String.split(card, " ") |> List.last()
      # {card_n, _} = Integer.parse(n)

      [winning, playing]
    end)
  end
end
