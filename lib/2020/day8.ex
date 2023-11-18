defmodule Aoc.Y2020.D8 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    set = MapSet.new()

    execute(set, lines, 0)
  end

  def part2(input) do
    :ok
  end

  def execute(set, lines, n, acc \\ 0) do
    line = Enum.at(lines, n)

    if n in set do
      acc
    else
      set = MapSet.put(set, n)

      case line do
        "nop " <> _ -> execute(set, lines, n + 1, acc)
        "acc " <> x -> execute(set, lines, n + 1, acc + String.to_integer(x))
        "jmp " <> x -> execute(set, lines, n + String.to_integer(x), acc)
      end
    end
  end

  def helper(input) do
    input |> parse_lines()
  end
end
