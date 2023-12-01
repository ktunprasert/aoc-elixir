defmodule Aoc.Y2023.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    lines
    |> Enum.reduce(0, fn line, acc ->
      [last, first] =
        case grab_digit(line) do
          [a, b] -> [a, b]
          [a] -> [a, a]
        end

      first * 10 + last + acc
    end)
  end

  def grab_digit(str), do: grab_digit(str, [])
  def grab_digit(<<>>, acc), do: acc

  def grab_digit(<<a, rest::binary>>, acc) do
    a =
      case a do
        a when a in ?1..?9 -> a - ?0
        _ -> nil
      end

    case {a, acc} do
      {nil, _} -> grab_digit(rest, acc)
      {a, n} when length(n) < 2 -> grab_digit(rest, [a | acc])
      {a, [_last, first]} -> grab_digit(rest, [a, first])
    end
  end

  @digits "one|two|three|four|five|six|seven|eight|nine|\\d"

  def part2(input) do
    re = ~r/(#{@digits})(?:.*(#{@digits}))?/

    input
    |> helper()
    |> Enum.reduce(0, fn line, acc ->
      Regex.run(re, line)
      |> Enum.take(-2)
      |> Enum.map(&infer_number/1)
      |> then(fn [a, b] -> a * 10 + b + acc end)
    end)
  end

  def infer_number("one"), do: 1
  def infer_number("two"), do: 2
  def infer_number("three"), do: 3
  def infer_number("four"), do: 4
  def infer_number("five"), do: 5
  def infer_number("six"), do: 6
  def infer_number("seven"), do: 7
  def infer_number("eight"), do: 8
  def infer_number("nine"), do: 9
  def infer_number(n), do: String.to_integer(n)

  def helper(input) do
    input |> parse_lines()
  end
end
