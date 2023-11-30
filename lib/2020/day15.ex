defmodule Aoc.Y2020.D15 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    {track, turns} = input |> helper()

    Stream.iterate({track, List.last(turns), length(turns)}, &play/1)
    |> Enum.find_value(fn {_, num, turn} -> if turn == 2020, do: num end)
  end

  def part2(input) do
    {track, turns} = input |> helper()

    Stream.iterate({track, List.last(turns), length(turns)}, &play/1)
    |> Enum.find_value(fn {_, num, turn} -> if turn == 30_000_000, do: num end)
  end

  def play({track, num, current_turn}), do: play(track, num, current_turn)

  def play(track, num, current_turn) do
    list = Map.get(track, num, [])

    n =
      case list |> length do
        n when n <= 1 -> 0
        _ -> Enum.take(list, 2) |> Enum.reduce(&(&2 - &1))
      end

    {
      Map.update(track, n, [current_turn + 1], fn lst -> [current_turn + 1 | lst] end),
      n,
      current_turn + 1
    }
  end

  def helper(input) do
    turns = input |> parse_lines(",") |> Enum.map(&String.to_integer/1)

    track =
      turns
      |> Enum.with_index(1)
      |> Enum.reduce(%{}, fn {num, idx}, map ->
        Map.put(map, num, [idx])
      end)

    {track, turns}
  end
end
