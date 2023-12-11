defmodule Aoc.Y2023.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input, empty_len \\ 2) do
    {galaxies, doubles} =
      input
      |> helper()

    coords = :ets.tab2list(galaxies)

    x_double = :ets.lookup_element(doubles, :x, 2) |> MapSet.new()
    y_double = :ets.lookup_element(doubles, :y, 2) |> MapSet.new()

    Enum.flat_map(coords, fn {pos1, fst} ->
      Enum.flat_map(coords, fn {pos2, snd} ->
        if fst < snd do
          [[pos1, pos2]]
        else
          []
        end
      end)
    end)
    |> Task.async_stream(fn [{x1, y1}, {x2, y2}] ->
      dist_x = manhattan_dist(x1, x2) + Enum.count(x_double, &(&1 in x1..x2)) * (empty_len - 1)
      dist_y = manhattan_dist(y1, y2) + Enum.count(y_double, &(&1 in y1..y2)) * (empty_len - 1)

      dist_x + dist_y
    end)
    |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)
  end

  def part2(input, empty_len \\ 1_000_000) do
    part1(input, empty_len)
  end

  def manhattan_dist(a, b) when a < b, do: b - a
  def manhattan_dist(a, b) when a > b, do: a - b
  def manhattan_dist(_, _), do: 0

  def helper(input) do
    galaxies =
      :ets.new(:galaxies, [
        :public,
        write_concurrency: true,
        read_concurrency: true,
      ])

    doubles =
      :ets.new(:doubles, [
        :public,
        :duplicate_bag,
        write_concurrency: true,
        read_concurrency: true,
      ])

    lines = input |> parse_lines()
    max_len = lines |> length()

    0..(max_len - 1)
    |> Enum.each(fn n ->
      :ets.insert(doubles, {:x, n})
      :ets.insert(doubles, {:y, n})
    end)

    no = :atomics.new(1, [])
    get_no = fn x -> :atomics.add_get(no, 1, x) end

    lines
    |> Enum.map(&String.to_charlist/1)
    |> Enum.with_index()
    |> Stream.flat_map(fn {self, x} ->
      Enum.with_index(self, fn char, y -> {char, x, y} end)
    end)
    |> Stream.dedup_by(fn {char, x, _} -> {char, x} end)
    |> Task.async_stream(fn
      {?#, x, y} ->
        n = get_no.(1)
        :ets.insert(galaxies, {{x, y}, n})
        :ets.match_delete(doubles, {:x, x})
        :ets.match_delete(doubles, {:y, y})

      _ ->
        nil
    end)
    |> Stream.run()

    {galaxies, doubles}
  end
end
