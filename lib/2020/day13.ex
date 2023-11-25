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
    ids = input |> helper2()

    chinese_remainder(ids)
  end

  def chinese_remainder(list) do
    product = Enum.reduce(list, 1, fn {n, _}, product -> n * product end)

    sum =
      Enum.reduce(list, 0, fn {id, remainder}, acc ->
        p = div(product, id)
        acc + remainder * mul_inv(p, id) * p
      end)

    rem(sum, product)
  end

  def mul_inv(a, mod) do
    gcd_extended(a, mod)
    |> elem(1)
    |> rem(mod)
  end

  defp gcd_extended(0, b), do: {b, 0, 1}

  defp gcd_extended(a, b) do
    {g, x, y} = gcd_extended(rem(b, a), a)
    {g, y - div(b, a) * x, x}
  end

  def helper(input) do
    [earliest, ids] = input |> parse_lines()

    earliest = String.to_integer(earliest)
    ids = ids |> String.split(",") |> Enum.reject(&(&1 == "x")) |> Enum.map(&String.to_integer/1)

    {earliest, ids}
  end

  def helper2(input) do
    [_, ids] = input |> parse_lines()

    ids
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.reject(fn
      {"x", _} -> true
      _ -> false
    end)
    |> Enum.map(fn {id, i} -> {String.to_integer(id), -i} end)
  end
end
