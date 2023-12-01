defmodule Aoc.Y2023.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    re = ~r/(\d)(?:.*(\d))?/

    lines
    |> Enum.reduce(0, fn line, acc ->
      Regex.run(re, line)
      |> Enum.take(-2)
      |> Enum.join()
      |> String.to_integer()
      |> then(fn n -> n + acc end)
    end)
  end

  @digits "one|two|three|four|five|six|seven|eight|nine|\\d"

  def part2(input) do
    re = ~r/(#{@digits})(?:.*(#{@digits}))?/

    input
    |> helper()
    |> Enum.reduce(0, fn line, acc ->
      Regex.run(re, line)
      |> Enum.take(-2)
      |> Enum.map(fn
        "one" -> 1
        "two" -> 2
        "three" -> 3
        "four" -> 4
        "five" -> 5
        "six" -> 6
        "seven" -> 7
        "eight" -> 8
        "nine" -> 9
        <<n::binary-size(1)>> -> String.to_integer(n)
      end)
      |> then(fn [a, b] -> a * 10 + b + acc end)
    end)
  end

  def helper(input) do
    input |> parse_lines()
  end
end
