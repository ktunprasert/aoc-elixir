defmodule Aoc.Y2020.D1 do
  use Aoc.Runner
import Aoc.Util

  def part1(input) do
    numbers = helper(input)

    Enum.reduce_while(
      numbers,
      0,
      fn i, acc ->
        case Enum.find(numbers, &(&1 == 2020 - i)) do
          nil -> {:cont, acc}
          j -> {:halt, i * j}
        end
      end
    )
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.to_integer/1)
  end
end
