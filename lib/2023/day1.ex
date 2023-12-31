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
      if a in ?0..?9 do
        a - ?0
      else
        nil
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

  def grab_digit_str(<<_head, rest::binary>> = str, acc) do
    case {str_num(str), acc} do
      {nil, _} -> grab_digit_str(rest, acc)
      {a, n} when length(n) < 2 -> grab_digit_str(rest, [a | acc])
      {a, [_last, first]} -> grab_digit_str(rest, [a, first])
    end
  end

  def str_num(str) do
    case str do
      <<a, _::binary>> when a in ?0..?9 -> a - ?0
      <<"one", _::binary>> -> 1
      <<"two", _::binary>> -> 2
      <<"three", _::binary>> -> 3
      <<"four", _::binary>> -> 4
      <<"five", _::binary>> -> 5
      <<"six", _::binary>> -> 6
      <<"seven", _::binary>> -> 7
      <<"eight", _::binary>> -> 8
      <<"nine", _::binary>> -> 9
      _ -> nil
    end
  end

  def helper(input) do
    input |> parse_lines()
  end
end
