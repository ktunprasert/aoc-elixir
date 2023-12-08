defmodule Aoc.Y2023.D8 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    [directions, table, _] = helper(input)

    Stream.cycle(directions)
    |> Enum.reduce_while({1, "AAA"}, fn dir, {acc, key} ->
      case :ets.lookup_element(table, key, k(dir)) do
        "ZZZ" -> {:halt, acc}
        new -> {:cont, {acc + 1, new}}
      end
    end)
  end

  def part2(input) do
    [directions, table, starts_table] = helper(input)

    starts = :ets.lookup_element(starts_table, :key, 2)
    dir_stream = Stream.cycle(directions)

    starts
    |> Enum.map(fn node ->
      dir_stream
      |> Enum.reduce_while({1, node}, fn dir, {acc, key} ->
        case :ets.lookup_element(table, key, k(dir)) do
          <<_::16, "Z">> -> {:halt, acc}
          next -> {:cont, {acc + 1, next}}
        end
      end)
    end)
    |> Enum.reduce(fn x, y -> div(x * y, Integer.gcd(x, y)) end)
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
    starts = :ets.new(:starts, [:public, :duplicate_bag])

    Task.async_stream(
      nodes |> parse_lines(),
      fn
        <<node::binary-3, _::binary-4, left::binary-3, _::binary-2, right::binary-3, _::binary>> ->
          :ets.insert(table, {node, left, right})

          with <<_, _, "A">> = node <- node do
            :ets.insert(starts, {:key, node})
          end
      end,
      ordered: false
    )
    |> Enum.to_list()

    [directions |> String.to_charlist(), table, starts]
  end
end
