defmodule Aoc.Y2020.D7 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @cursor "shiny gold"

  def part1(input) do
    bags = helper(input)

    map =
      for [name | mappings] <- bags, into: %{} do
        case mappings do
          [] ->
            {name, nil}

          mappings ->
            val = mappings |> Enum.map(fn [n, name] -> {name, n} end) |> Enum.into(%{})
            {name, val}
        end
      end

    map
    |> Enum.map(fn {_, small_map} ->
      deep_check_map(map, small_map)
    end)
    |> Enum.count(& &1)
  end

  def part2(input) do
    :ok
  end

  def deep_check_map(nil, _), do: false
  def deep_check_map(_, nil), do: false

  def deep_check_map(map, small_map) do
    case Map.get(small_map, @cursor) do
      nil ->
        keys = Map.keys(small_map)

        Enum.any?(keys, fn k ->
          deep_check_map(map, Map.get(map, k))
        end)

      _ ->
        true
    end
  end

  def helper(input) do
    lines =
      input
      |> String.replace(~r/(bags|bag|contain|,|\.|no other)/, "")
      |> parse_lines()
      |> Enum.map(fn line ->
        bags = line |> String.split(~r/\s{2,}/)

        if length(bags) > 1 do
          [bag | rest] = bags
          [bag | rest |> Enum.map(&String.split(&1, " ", parts: 2))]
        else
          bags
        end
      end)

    lines
  end
end
