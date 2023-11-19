defmodule Aoc.Y2020.D8 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    set = MapSet.new()

    {:oops, acc} = execute(set, lines, 0)
    acc
  end

  def part2(input) do
    lines = helper(input)

    0..length(lines)
    |> Stream.map(&replace_instructions(lines, &1))
    |> Enum.reduce_while({nil, MapSet.new()}, fn lines, {acc, executed} ->
      if lines in executed do
        {:cont, {acc, executed}}
      else
        executed = MapSet.put(executed, lines)

        case execute(MapSet.new(), lines, 0) do
          {:ok, acc} -> {:halt, acc}
          {:oops, _} -> {:cont, {acc, executed}}
        end
      end
    end)
  end

  def replace_instructions(lines, index) do
    lines
    |> List.replace_at(
      index,
      Enum.at(lines, index)
      |> then(fn
        "nop " <> n -> "jmp #{n}"
        "jmp " <> n -> "nop #{n}"
        line -> line
      end)
    )
  end

  def execute(set, lines, n, acc \\ 0) do
    line = Enum.at(lines, n)

    if n in set do
      {:oops, acc}
    else
      set = MapSet.put(set, n)

      case line do
        "nop " <> _ -> execute(set, lines, n + 1, acc)
        "acc " <> x -> execute(set, lines, n + 1, acc + String.to_integer(x))
        "jmp " <> x -> execute(set, lines, n + String.to_integer(x), acc)
        nil -> {:ok, acc}
      end
    end
  end

  def helper(input) do
    input |> parse_lines()
  end
end
