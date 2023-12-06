defmodule Aoc.Y2023.D6 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    races =
      helper(input)
      |> Enum.map(&Enum.map(&1, fn i -> String.to_integer(i) end))
      |> Enum.zip()

    races
    |> Enum.reduce(1, fn {t, d}, acc -> acc * win_quadratic(t, d) end)
  end

  def win_quadratic(time, distance) do
    disc = :math.sqrt(time * time - 4 * distance)
    t1 = (time + disc) / 2.0
    t2 = (time - disc) / 2.0

    ceil(t1) - floor(t2) - 1
  end

  def part2(input) do
    {time, dist} =
      helper(input)
      |> Enum.map(&(Enum.join(&1) |> String.to_integer()))
      |> List.to_tuple()

    win_quadratic(time, dist)
  end

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn
      line ->
        line
        |> String.split()
        |> tl()
    end)
  end
end
