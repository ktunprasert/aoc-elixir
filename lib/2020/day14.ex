defmodule Aoc.Y2020.D14 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    lines = helper(input)

    lines
    |> Enum.reduce({%{}, nil}, fn line, {map, mask} ->
      case parse(line) do
        {:mask, mask} ->
          {map, mask}

        {:mem, addr, bitstring} ->
          {Map.put(map, addr, mask(mask, String.pad_leading(bitstring, 36, "0"))), mask}
      end
    end)
    |> elem(0)
    |> Enum.reduce(0, fn {_, bitstring}, acc ->
      {dec, _} = bitstring |> List.to_string() |> Integer.parse(2)

      dec + acc
    end)
  end

  def part2(input) do
    :ok
  end

  def parse("mask = " <> mask) do
    {:mask, mask}
  end

  def parse("mem" <> mem) do
    [_, addr, dec] = Regex.run(~r/\[(\d+)\] = (\d+)/, mem)
    {:mem, addr, dec |> String.to_integer() |> Integer.to_string(2)}
  end

  def mask(mask, num) do
    mask(mask, num, [])
  end

  def mask(_, <<>>, acc), do: acc |> Enum.reverse()

  def mask(<<a, a_rest::binary>>, <<b, b_rest::binary>>, acc) do
    case {a, b} do
      {?1, _} -> mask(a_rest, b_rest, [?1 | acc])
      {?0, _} -> mask(a_rest, b_rest, [?0 | acc])
      _ -> mask(a_rest, b_rest, [b | acc])
    end
  end

  def helper(input) do
    input |> parse_lines()
  end
end
