defmodule Aoc.Y2020.D13 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    {earliest, ids} = input |> helper()

    ids
    |> Enum.map(fn factor ->
      time = div(earliest, factor) * factor

      {factor, time + factor - earliest}
    end)
    |> Enum.min_by(&elem(&1, 1))
    |> Tuple.product()
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    [earliest, ids] = input |> parse_lines()

    earliest = String.to_integer(earliest)
    ids = ids |> String.split(",") |> Enum.reject(&(&1 == "x")) |> Enum.map(&String.to_integer/1)

    {earliest, ids}
  end
end
