defmodule Aoc.Y2023.D1 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    lines
    |> Enum.reduce(0, fn line, acc ->
      case grab_digit(line) do
        [last, first] -> first * 10 + last + acc
        [same] -> same * 10 + same + acc
      end
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

  def part2(input) do
    input
    |> helper()
    |> Enum.reduce(0, fn line, acc ->
      case grab_digit_str(line) do
        [last, first] -> first * 10 + last + acc
        [same] -> same * 10 + same + acc
      end
    end)
  end

  def grab_digit_str(str), do: grab_digit_str(str, [])
  def grab_digit_str(<<>>, acc), do: acc

  def grab_digit_str(<<a, rest::binary>> = str, acc) do
    a =
      case {a, str} do
        {a, _} when a in ?0..?9 -> a - ?0
        {_, <<"one", _::binary>>} -> 1
        {_, <<"two", _::binary>>} -> 2
        {_, <<"three", _::binary>>} -> 3
        {_, <<"four", _::binary>>} -> 4
        {_, <<"five", _::binary>>} -> 5
        {_, <<"six", _::binary>>} -> 6
        {_, <<"seven", _::binary>>} -> 7
        {_, <<"eight", _::binary>>} -> 8
        {_, <<"nine", _::binary>>} -> 9
        _ -> nil
      end

    case {a, acc} do
      {nil, _} -> grab_digit_str(rest, acc)
      {a, n} when length(n) < 2 -> grab_digit_str(rest, [a | acc])
      {a, [_last, first]} -> grab_digit_str(rest, [a, first])
    end
  end

  def helper(input) do
    input |> parse_lines()
  end
end
