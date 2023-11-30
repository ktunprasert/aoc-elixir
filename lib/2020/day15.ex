defmodule Aoc.Y2020.D15 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    turns = input |> helper()

    turns |> Enum.with_index(1) |> Enum.each(fn {n, i} -> Process.put(n, {i, nil}) end)

    play_proc(List.last(turns), length(turns), 2020)
  end

  def part2(input) do
    turns = input |> helper()

    turns |> Enum.with_index(1) |> Enum.each(fn {n, i} -> Process.put(n, {i, nil}) end)

    play_proc(List.last(turns), length(turns), 30_000_000)
  end

  def play_proc(n, target, target), do: n

  def play_proc(prev_num, turn, target) do
    {last_1, last_2} = Process.get(prev_num, {nil, nil})

    n =
      case {last_1, last_2} do
        {nil, nil} -> 0
        {_, nil} -> 0
        {x, y} -> x - y
      end

    new_state =
      case Process.get(n) do
        nil -> {turn + 1, nil}
        {i, _} -> {turn + 1, i}
      end

    Process.put(n, new_state)

    play_proc(n, turn + 1, target)
  end

  def play(_, num, target, target), do: num

  def play(track, num, current_turn, target) do
    {last_1, last_2} = Map.get(track, num, {nil, nil})

    n =
      case {last_1, last_2} do
        {x, y} when x == nil or y == nil -> 0
        {x, y} -> x - y
      end

    track = Map.update(track, n, {current_turn + 1, nil}, fn {x, _} -> {current_turn + 1, x} end)

    play(track, n, current_turn + 1, target)
  end

  def helper(input) do
    turns = input |> parse_lines(",") |> Enum.map(&String.to_integer/1)
    # track =
    #   turns
    #   |> Enum.with_index(1)
    #   |> Enum.reduce(%{}, fn {num, idx}, map ->
    #     Map.put(map, num, {idx, nil})
    #   end)

    turns
  end
end
