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
    [directions, table, starts] = helper(input)
    dir_stream = Stream.cycle(directions)

    starts
    |> Task.async_stream(fn node ->
      dir_stream
      |> Enum.reduce_while({1, node}, fn dir, {acc, key} ->
        case :ets.lookup_element(table, key, k(dir)) do
          <<_::16, "Z">> -> {:halt, acc}
          next -> {:cont, {acc + 1, next}}
        end
      end)
    end)
    |> Enum.reduce(fn {:ok, x}, {:ok, y} -> div(x * y, Integer.gcd(x, y)) end)
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

    starts =
      nodes
      |> parse_lines()
      |> Task.async_stream(
        fn
          <<node::binary-3, _::binary-4, left::binary-3, _::binary-2, right::binary-3, _::binary>> ->
            :ets.insert(table, {node, left, right})
            node
        end,
        ordered: false
      )
      |> Enum.flat_map(fn
        {:ok, <<_::binary-2, "A">> = n} -> [n]
        {:ok, _} -> []
      end)

    [directions |> String.to_charlist(), table, starts]
  end
end
