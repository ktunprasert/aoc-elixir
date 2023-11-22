defmodule Aoc.Y2020.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @empty "L"
  @occupied "#"
  @floor "."

  def part1(input) do
    grid = helper(input)

    Stream.iterate(grid, &play/1)
    |> Enum.reduce_while(nil, fn grid, prev ->
      case grid do
        ^prev -> {:halt, prev |> List.flatten()}
        _ -> {:cont, grid}
      end
    end)
    |> Enum.count(&(&1 == @occupied))
  end

  def part2(input) do
    :ok
  end

  def play(grid) do
    rows = length(grid)
    cols = length(Enum.at(grid, 0))

    for x <- 0..(rows - 1) do
      for y <- 0..(cols - 1) do
        apply_rule(grid, {x, y}, at(grid, {x, y}))
      end
    end
  end

  def apply_rule(_grid, {_x, _y}, @floor), do: @floor

  def apply_rule(grid, {x, y}, self = @empty) do
    case {x, y}
         |> get_adjacent()
         |> Enum.map(&at(grid, &1))
         |> Enum.count(&(&1 == @occupied)) do
      0 -> @occupied
      _ -> self
    end
  end

  def apply_rule(grid, {x, y}, self = @occupied) do
    case {x, y}
         |> get_adjacent()
         |> Enum.map(&at(grid, &1))
         |> Enum.count(&(&1 == @occupied)) do
      n when n >= 4 -> @empty
      _ -> self
    end
  end

  def get_adjacent({x, y}) do
    vector = [-1, 0, 1]

    for i <- vector, j <- vector, {i, j} != {0, 0} do
      {x + i, y + j}
    end
    |> Enum.filter(fn {i, j} -> i >= 0 and j >= 0 end)
  end

  def at(grid, {row, col}), do: grid |> Enum.at(row, []) |> Enum.at(col)

  def helper(input) do
    input |> parse_lines() |> Enum.map(&String.graphemes/1)
  end
end
