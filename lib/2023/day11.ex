defmodule Aoc.Y2023.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input, empty_len \\ 2) do
    {galaxies, doubles} =
      input
      |> helper()

    coords = :ets.tab2list(galaxies)

    x_double = :ets.lookup_element(doubles, :x, 2)
    y_double = :ets.lookup_element(doubles, :y, 2)

    Stream.flat_map(coords, fn {pos1, fst} ->
      Stream.flat_map(coords, fn {pos2, snd} ->
        if fst < snd do
          [[pos1, pos2]]
        else
          []
        end
      end)
    end)
    |> Task.async_stream(fn [{x1, y1}, {x2, y2}] ->
      dist_x = Range.size(x1..x2) + Enum.count(x_double, &(&1 in x1..x2)) * (empty_len - 1) - 1
      dist_y = Range.size(y1..y2) + Enum.count(y_double, &(&1 in y1..y2)) * (empty_len - 1) - 1

      dist_x + dist_y
    end)
    |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)
  end

  def part2(input, empty_len \\ 1_000_000) do
    part1(input, empty_len)
  end

  def helper(input) do
    galaxies = :ets.new(:galaxies, [:public, write_concurrency: true, read_concurrency: true])
    doubles = :ets.new(:doubles, [:public, :duplicate_bag])

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
    |> Stream.map(&String.to_charlist/1)
    |> Stream.with_index()
    |> Task.async_stream(fn {line, x} ->
      line
      |> Stream.with_index()
      |> Enum.each(fn
        {?#, y} ->
          n = get_no.(1)
          :ets.insert(galaxies, {{x, y}, n})
          :ets.match_delete(doubles, {:x, x})
          :ets.match_delete(doubles, {:y, y})
          n

        _ ->
          get_no.(0)
      end)
    end)
    |> Stream.run()

    {galaxies, doubles}
  end
end
