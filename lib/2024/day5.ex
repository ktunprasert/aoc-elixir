defmodule Aoc.Y2024.D5 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    {rules, inverse_rules, instructs} =
      helper(input)

    instructs
    |> Enum.reject(&check_fail(&1, inverse_rules))
    |> Enum.map(fn lst ->
      Enum.drop(lst, (length(lst) - 1) |> div(2))
    end)
    |> Enum.reduce(0, fn [h | _], acc ->
      h
      |> String.to_integer()
      |> then(fn n -> acc + n end)
    end)
  end

  def part2(input) do
    :ok
  end

  def check_fail([], _), do: false

  def check_fail([h | rest], inverse_rules) do
    Enum.any?(rest, fn x -> Map.get(inverse_rules, {h, x}) == :fail end) ||
      check_fail(rest, inverse_rules)
  end

  def helper(input) do
    [rules, instructs] =
      input |> parse_lines("\n\n")

    rules =
      rules
      |> String.split("\n")
      |> Enum.map(fn <<n1::binary-size(2), ?|, n2::binary-size(2)>> -> {n1, n2} end)

    inverse_rules =
      rules
      |> Enum.map(fn {n1, n2} -> {{n2, n1}, :fail} end)
      |> Enum.into(%{})

    instructs =
      instructs
      |> String.split("\n")
      |> Enum.map(fn line ->
        String.split(line, ",")
      end)

    {rules, inverse_rules, instructs}
  end
end
