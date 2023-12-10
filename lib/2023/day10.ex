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

    :ets.lookup_element(table, :start, 2)
    |> orthogonal_dirs()
    |> Stream.flat_map(fn {pos, from} ->
      case :ets.lookup(table, pos) do
        [{_, sym}] -> [{pos, sym, from}]
        _ -> []
      end
    end)
    |> Stream.flat_map(&traverse_rel(&1, table, traverse_map, 0))
    |> then(&{&1, 1})
    |> Stream.iterate(fn {pos_list, dist} ->
      pos_list
      |> Enum.flat_map(&traverse_rel(&1, table, traverse_map, dist))
      |> then(&{&1, dist + 1})
    end)
    |> Enum.reduce_while(nil, fn
      {[], dist}, _ -> {:halt, dist}
      _, _ -> {:cont, nil}
    end)
  end

  def part2(input) do
    :ok
  end

  def traverse_rel({pos, sym, from_dir}, table, traverse_map, prev),
    do: traverse_rel(pos, sym, from_dir, table, traverse_map, prev)

  def traverse_rel(pos, sym, from_dir, table, traverse_map, prev) do
    case pos |> move_rel(sym, from_dir) do
      nil ->
        []

      {new_pos, dir} ->
        sym = :ets.lookup_element(table, new_pos, 2)

        case :ets.lookup(traverse_map, new_pos) do
          [] ->
            :ets.insert(traverse_map, {new_pos, prev + 1})
            [{new_pos, sym, dir}]

          [{_, found}] when prev + 1 < found ->
            :ets.insert(traverse_map, {new_pos, prev + 1})
            [{new_pos, sym, dir}]

          _ ->
            []
        end
    end
  end

  def move_rel(pos, sym, from_dir) do
    case {sym, from_dir} do
      {?|, :s} -> {pos +++ {-1, 0}, :s}
      {?|, :n} -> {pos +++ {1, 0}, :n}
      {?-, :w} -> {pos +++ {0, 1}, :w}
      {?-, :e} -> {pos +++ {0, -1}, :e}
      {?L, :n} -> {pos +++ {0, 1}, :w}
      {?L, :e} -> {pos +++ {-1, 0}, :s}
      {?J, :n} -> {pos +++ {0, -1}, :e}
      {?J, :w} -> {pos +++ {-1, 0}, :s}
      {?7, :s} -> {pos +++ {0, -1}, :e}
      {?7, :w} -> {pos +++ {1, 0}, :n}
      {?F, :s} -> {pos +++ {0, 1}, :w}
      {?F, :e} -> {pos +++ {1, 0}, :n}
      _ -> nil
    end
  end

  def {a, b} +++ {x, y}, do: {a + x, b + y}

  def orthogonal_dirs({x, y}) do
    [
      {{x - 1, y}, :s},
      {{x + 1, y}, :n},
      {{x, y + 1}, :w},
      {{x, y - 1}, :e}
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
