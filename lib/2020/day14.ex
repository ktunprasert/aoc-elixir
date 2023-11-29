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

        {:mem, addr, dec} ->
          bitstring = dec |> Integer.to_string(2)
          {Map.put(map, addr, mask(mask, bitstring)), mask}
      end
    end)
    |> elem(0)
    |> Enum.reduce(0, fn {_, bitstring}, acc ->
      {dec, _} = bitstring |> List.to_string() |> Integer.parse(2)

      dec + acc
    end)
  end

  def part2(input) do
    lines = helper(input)

    lines
    |> Enum.reduce({%{}, nil}, fn line, {map, mask} ->
      case parse(line) do
        {:mask, mask} ->
          {map, mask}

        {:mem, addr, dec} ->
          addr_bitstring = addr |> Integer.to_string(2)
          {addr_mask, num_x} = mask_v2(mask, addr_bitstring)

          map =
            0..(2 ** num_x - 1)
            |> Enum.map(fn n ->
              mask_v3(
                addr_mask |> List.to_string(),
                Integer.to_string(n, 2) |> String.pad_leading(num_x, "0")
              )
              |> List.to_string()
              |> Integer.parse(2)
            end)
            |> Enum.reduce(map, fn {addr, _}, map ->
              Map.put(map, addr, dec)
            end)

          {map, mask}
      end
    end)
    |> elem(0)
    |> Enum.reduce(0, fn {_key, val}, acc -> val + acc end)
  end

  def mask_v3(mask_x, num) do
    mask_v3(mask_x, num, [])
  end

  def mask_v3(<<>>, <<>>, acc), do: acc |> Enum.reverse()
  def mask_v3(<<a, a_rest::binary>>, <<>>, acc), do: mask_v3(a_rest, <<>>, [a | acc])

  def mask_v3(<<a, a_rest::binary>>, <<b, b_rest::binary>> = num, acc) do
    case {a, b} do
      {?X, _} -> mask_v3(a_rest, b_rest, [b | acc])
      _ -> mask_v3(a_rest, num, [a | acc])
    end
  end

  def parse("mask = " <> mask) do
    {:mask, mask}
  end

  def parse("mem" <> mem) do
    [_, addr, dec] = Regex.run(~r/\[(\d+)\] = (\d+)/, mem)
    {:mem, addr |> String.to_integer(), dec |> String.to_integer()}
  end

  def mask_v2(mask, num) do
    mask_v2(mask, num |> String.pad_leading(36, "0"), [], 0)
  end

  def mask_v2(_, <<>>, acc, num_x), do: {acc |> Enum.reverse(), num_x}

  def mask_v2(<<a, a_rest::binary>>, <<b, b_rest::binary>>, acc, nx) do
    case {a, b} do
      {?1, _} -> mask_v2(a_rest, b_rest, [?1 | acc], nx)
      {?0, _} -> mask_v2(a_rest, b_rest, [b | acc], nx)
      {?X, _} -> mask_v2(a_rest, b_rest, [?X | acc], nx + 1)
      _ -> mask_v2(a_rest, b_rest, [b | acc], nx)
    end
  end

  def mask(mask, num) do
    mask(mask, num |> String.pad_leading(36, "0"), [])
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
