defmodule Aoc.Y2023.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
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
      dist_x = Range.size(x1..x2) + Enum.count(x_double, &(&1 in x1..x2)) - 1
      dist_y = Range.size(y1..y2) + Enum.count(y_double, &(&1 in y1..y2)) - 1

      dist_x + dist_y
    end)
    |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    galaxies = :ets.new(:galaxies, write_concurrency: true, read_concurrency: true)
    doubles = :ets.new(:doubles, [:public, :duplicate_bag])

    rows =
      input
      |> parse_lines()
      |> Stream.map(&String.to_charlist/1)

    Stream.zip(rows)
    |> Stream.with_index()
    |> Task.async_stream(fn {line, y} ->
      if line
         |> Tuple.to_list()
         |> Enum.all?(&(&1 == ?.)) do
        :ets.insert(doubles, {:y, y})
      end
    end)
    |> Stream.run()

    rows
    |> Stream.with_index()
    |> Enum.reduce(1, fn {line, x}, no ->
      if Enum.all?(line, &(&1 == ?.)) do
        :ets.insert(doubles, {:x, x})
        no
      else
        line
        |> Stream.with_index()
        |> Enum.reduce(no, fn
          {?#, y}, n ->
            :ets.insert(galaxies, {{x, y}, n})
            n + 1

          _, n ->
            n
        end)
      end
    end)

    {galaxies, doubles}
  end
end
