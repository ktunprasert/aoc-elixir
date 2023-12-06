defmodule Aoc.Y2023.D6 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    races =
      helper(input)
      |> Enum.map(&Enum.map(&1, fn i -> String.to_integer(i) end))
      |> Enum.zip()

    races
    |> Enum.reduce(1, fn {time, dist}, acc ->
      1..(time - 1)
      |> Enum.reduce_while(0, fn i, acc ->
        distance = (time - i) * i

        case {acc, distance} do
          {0, n} when n < dist -> {:cont, acc}
          {_, n} when n > dist -> {:cont, acc + 1}
          {_, n} when n < dist -> {:halt, acc}
          _ -> {:cont, acc}
        end
      end)
      |> then(fn possible -> acc * possible end)
    end)
  end

  def part2(input) do
    {time, dist} =
      helper(input)
      |> Enum.map(&(Enum.join(&1) |> String.to_integer()))
      |> List.to_tuple()

    Enum.reduce_while(1..(time - 1), 0, fn i, acc ->
      moved = (time - i) * i

      case {acc, moved} do
        {0, n} when n < dist -> {:cont, acc}
        {_, n} when n > dist -> {:cont, acc + 1}
        {_, n} when n < dist -> {:halt, acc}
        _ -> {:cont, acc}
      end
    end)
  end

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn
      line ->
        line
        |> String.split()
        |> Enum.drop(1)
    end)
  end
end
