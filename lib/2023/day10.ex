defmodule Aoc.Y2023.D10 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @valid [?|, ?-, ?L, ?J, ?7, ?F, ?S]
  @from_north [?|, ?L, ?J]
  @from_south [?|, ?7, ?F]
  @from_east [?-, ?L, ?F]
  @from_west [?-, ?J, ?7]

  def part1(input) do
    traverse_map = :ets.new(:traverse_map, [:duplicate_bag])
    table = helper(input)
    start = :ets.lookup_element(table, :start, 2)

    {[start], 0}
    |> Stream.iterate(fn {pos_list, dist} ->
      pos_list
      |> Enum.flat_map(&traverse(&1, table, traverse_map, dist))
      |> then(&{&1, dist + 1})
    end)
    |> Enum.take_while(fn {pos_list, _dist} -> pos_list !== [] end)
    |> Enum.max_by(fn {_pos_list, dist} -> dist end)
    |> then(fn {_pos_list, dist} -> dist + 1 end)
    |> dbg
  end

  def part2(input) do
    :ok
  end

  def traverse(pos, table, traverse_map, prev) do
    pos
    |> orthogonal_dirs()
    |> Enum.flat_map(fn {pos, dir} ->
      case :ets.lookup(table, pos) do
        [] ->
          []

        [{_, char}] ->
          case {char, dir} do
            {char, :n} when char in @from_south -> [pos]
            {char, :s} when char in @from_north -> [pos]
            {char, :e} when char in @from_west -> [pos]
            {char, :w} when char in @from_east -> [pos]
            _ -> []
          end
      end
    end)
    |> Enum.flat_map(fn pos ->
      case :ets.lookup(traverse_map, pos) do
        [] ->
          :ets.insert(traverse_map, {pos, prev + 1})
          [pos]

        [{_, found}] when prev + 1 <= found ->
          :ets.insert(traverse_map, {pos, prev + 1})
          [pos]

        _ ->
          []
      end
    end)
  end

  def orthogonal_dirs({x, y}) do
    [
      {{x + 1, y}, :n},
      {{x - 1, y}, :s},
      {{x, y + 1}, :e},
      {{x, y - 1}, :w}
    ]
  end

  def helper(input) do
    table = :ets.new(:input, [:public, write_concurrency: true, read_concurrency: true])

    input
    |> parse_lines()
    |> Stream.with_index()
    |> Task.async_stream(fn {line, x} ->
      line
      |> String.to_charlist()
      |> Stream.with_index()
      |> Enum.each(fn
        {char, y} when char in @valid ->
          if ?S == char,
            do: :ets.insert(table, {:start, {x, y}}),
            else: :ets.insert(table, {{x, y}, char})

        _ ->
          :pass
      end)
    end)
    |> Stream.run()

    table
  end
end
