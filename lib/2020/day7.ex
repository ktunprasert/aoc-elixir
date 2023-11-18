defmodule Aoc.Y2020.D7 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @cursor "shiny gold"

  def part1(input) do
    map = helper(input)

    map
    |> Enum.map(fn {_, small_map} ->
      deep_check(map, small_map)
    end)
    |> Enum.count(& &1)
  end

  def part2(input) do
    map = helper(input)

    deep_sum(map, @cursor)
  end

  def deep_sum(map, key) do
    case Map.get(map, key) do
      :self ->
        0

      %{} = small_map ->
        small_map
        |> Enum.reduce(0, fn {k, v}, acc ->
          acc + v + v * deep_sum(map, k)
        end)
    end
  end

  def deep_check(_, :self), do: false

  def deep_check(map, small_map) do
    case Map.get(small_map, @cursor) do
      nil ->
        keys = Map.keys(small_map)

        Enum.any?(keys, fn k ->
          deep_check(map, Map.get(map, k))
        end)

      _ ->
        true
    end
  end

  def helper(input) do
    bags =
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

    for [name | mappings] <- bags, into: %{} do
      case mappings do
        [] ->
          {name, :self}

        mappings ->
          val =
            mappings
            |> Enum.map(fn [n, name] -> {name, n |> String.to_integer()} end)
            |> Enum.into(%{})

          {name, val}
      end
    end
  end
end
