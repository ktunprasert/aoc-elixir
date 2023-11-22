defmodule Aoc.Y2020.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @empty "L"
  @occupied "#"
  @floor "."

  def part1(input) do
    grid = helper(input)

    adjacent = precompute_adjacent(grid)

    Stream.iterate(grid, &play(&1, adjacent))
    |> Enum.reduce_while(nil, fn grid, prev ->
      case grid do
        ^prev -> {:halt, prev}
        _ -> {:cont, grid}
      end
    end)
    |> Enum.count(fn {_, v} -> v == @occupied end)
  end

  def part2(input) do
    :ok
  end

  def play(grid, adjacent) do
    Enum.reduce(grid, %{}, fn {{x, y}, seat}, acc ->
      Map.put(acc, {x, y}, apply_rule(grid, adjacent, {x, y}, seat))
    end)
  end

  def apply_rule(grid, adjacent, pos, self = @empty) do
    case Map.get(adjacent, pos) |> Enum.count(&(at(grid, &1) == @occupied)) do
      0 -> @occupied
      _ -> self
    end
  end

  def apply_rule(grid, adjacent, pos, self = @occupied) do
    case Map.get(adjacent, pos) |> Enum.count(&(at(grid, &1) == @occupied)) do
      n when n >= 4 -> @empty
      _ -> self
    end
  end

  def apply_rule(_grid, _, _, self), do: self

  def precompute_adjacent(grid) do
    grid
    |> Enum.reduce(%{}, fn {{x, y}, _}, acc ->
      Map.put(acc, {x, y}, get_adjacent({x, y}))
    end)
  end

  def get_adjacent({x, y}) do
    vector = [-1, 0, 1]

    for i <- vector, j <- vector, {i, j} != {0, 0} && x + i >= 0 && y + j >= 0 do
      {x + i, y + j}
    end
  end

  def at(grid, pos), do: Map.get(grid, pos)

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.with_index(fn el, idx ->
      {idx, el |> String.graphemes() |> Enum.with_index(fn v, k -> {k, v} end)}
    end)
    |> Enum.reduce(%{}, fn {i, row}, acc ->
      Enum.reduce(row, acc, fn {j, col}, acc ->
        Map.put(acc, {i, j}, col)
      end)
    end)
  end
end
