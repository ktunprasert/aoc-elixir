defmodule Aoc.Y2020.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    numbers = helper(input)

    Enum.reduce_while(
      Stream.flat_map(numbers, fn i -> Stream.map(numbers, fn j -> [i, j] end) end),
      0,
      fn
        [i, j], _acc when i + j == 2020 ->
          {:halt, i * j}

        _, acc ->
          {:cont, acc}
      end
    )
  end

  def part2(input) do
    numbers = helper(input)

    Enum.reduce_while(
      Stream.flat_map(numbers, fn i ->
        Stream.flat_map(numbers, fn j ->
          Stream.map(numbers, fn k -> [i, j, k] end)
        end)
      end),
      0,
      fn
        [i, j, k], _acc when i + j + k == 2020 ->
          {:halt, i * j * k}

        _, acc ->
          {:cont, acc}
      end
    )
  end

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.to_integer/1)
  end
end
