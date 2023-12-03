defmodule Aoc.Y2023.D3 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    {_, nums, syms} = input |> helper()

    for {:sym, _, y, x} <- syms,
        {n, yrange, x_i..x_j} <- nums,
        y in yrange && x in (x_i - 1)..(x_j + 1),
        into: MapSet.new() do
      {n, yrange, x_i..x_j}
    end
    |> Enum.reduce(0, fn {n, _, _}, acc -> n + acc end)
  end

  def part2(input) do
    {_, nums, syms} = input |> helper()

    syms = Enum.filter(syms, fn {_, sym, _, _} -> sym == ?* end)

    syms
    |> Enum.map(fn {_, _, y, x} ->
      Enum.reduce(nums, [], fn {n, yrange, x_i..x_j}, acc ->
        if y in yrange && x in (x_i - 1)..(x_j + 1) do
          [{n, yrange, x_i..x_j} | acc]
        else
          acc
        end
      end)
    end)
    |> Enum.reduce(0, fn
      [{i, _, _}, {j, _, _}], acc -> acc + i * j
      _, acc -> acc
    end)
  end

  def parse_line(str), do: parse_line(str, [], 0, 0, 0)

  def parse_line(<<>>, acc, num, x, y) do
    if num != 0 do
      [{:num, num, x..(y - 1)} | acc]
    else
      acc
    end
  end

  def parse_line(<<n, rest::binary>>, acc, num, x, y) when n in ?0..?9 do
    num = num * 10 + n - ?0

    parse_line(rest, acc, num, x, y + 1)
  end

  def parse_line(<<?., rest::binary>>, acc, num, x, y) do
    if num == 0 do
      parse_line(rest, acc, num, x + 1, y + 1)
    else
      parse_line(rest, [{:num, num, x..(y - 1)} | acc], 0, y + 1, y + 1)
    end
  end

  # when symbols
  def parse_line(<<s, rest::binary>>, acc, num, x, y) do
    if num != 0 do
      acc = [{:num, num, x..(y - 1)} | acc]
      parse_line(rest, [{:sym, s, y} | acc], 0, y + 1, y + 1)
    else
      parse_line(rest, [{:sym, s, y} | acc], 0, x + 1, y + 1)
    end
  end

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.reduce({0, [], []}, fn line, {y, nums, syms} ->
      parsed = line |> parse_line()

      {nums, syms} =
        Enum.reduce(parsed, {nums, syms}, fn
          el, {nums, syms} ->
            case el do
              {:num, n, range} -> {[{n, (y - 1)..(y + 1), range} | nums], syms}
              {:sym, sym, x} -> {nums, [{:sym, sym, y, x} | syms]}
            end
        end)

      {y + 1, nums, syms}
    end)
  end
end
