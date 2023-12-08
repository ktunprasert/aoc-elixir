defmodule Aoc.Y2023.D8 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    [directions, table] = helper(input)

    Stream.cycle(directions)
    |> Enum.reduce_while({1, "AAA"}, fn dir, {acc, key} ->
      case :ets.lookup_element(table, key, k(dir)) do
        "ZZZ" -> {:halt, acc}
        new -> {:cont, {acc + 1, new}}
      end
    end)
  end

  def part2(input) do
    :ok
  end

  def k(?L), do: 2
  def k(?R), do: 3

  def helper(input) do
    [
      directions,
      nodes
    ] =
      input |> parse_lines("\n\n")

    table = :ets.new(:words, [:public, write_concurrency: true])

    Task.async_stream(
      nodes |> parse_lines(),
      fn
        <<
          node::binary-size(3),
          _::binary-size(4),
          left::binary-size(3),
          _::binary-size(2),
          right::binary-size(3),
          _::binary
        >> ->
          # :ets.update_element(table, node, {left, right})
          :ets.insert(table, {node, left, right})
      end,
      ordered: false
    )
    |> Enum.to_list()

    # |> Task.await_many()

    # :ets.tab2list(table) |> dbg

    # :ets.lookup_element(table, "AAA", 2) |> dbg

    [directions |> String.to_charlist(), table]
  end
end
