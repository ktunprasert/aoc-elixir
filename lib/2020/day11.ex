defmodule Aoc.Y2020.D11 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @empty "L"
  @occupied "#"
  @floor "."

  @vectors [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0},
    {1, 1},
    {1, -1},
    {-1, 1},
    {-1, -1}
  ]

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
    grid = helper(input)

    bound = grid |> Map.keys() |> Enum.max()

    Stream.iterate(grid, &play2(&1, bound))
    |> Enum.reduce_while(nil, fn grid, prev ->
      case grid do
        ^prev -> {:halt, prev}
        _ -> {:cont, grid}
      end
    end)
    |> Enum.count(fn {_, v} -> v == @occupied end)
  end

  def play2(grid, {rows, columns}) do
    Enum.reduce(grid, %{}, fn {{x, y}, seat}, acc ->
      count =
        @vectors
        |> Enum.map(fn {i, j} ->
          Stream.unfold({x, y}, fn
            {x, y} when x < 0 or y < 0 or x > rows or y > columns -> nil
            {x, y} -> {{x, y}, {x + i, y + j}}
          end)
          |> Stream.drop(1)
          |> Stream.map(&at(grid, &1))
          |> Enum.reduce_while(0, fn seat, acc ->
            case seat do
              @occupied -> {:halt, 1}
              @empty -> {:halt, 0}
              @floor -> {:cont, acc}
            end
          end)
        end)
        |> Enum.sum()

      new_seat =
        case {seat, count} do
          {@occupied, n} when n >= 5 -> @empty
          {@empty, 0} -> @occupied
          _ -> seat
        end

      Map.put(acc, {x, y}, new_seat)
    end)
  end

  def play(grid, adjacent) do
    Enum.reduce(grid, %{}, fn {{x, y}, seat}, acc ->
      count =
        Map.get(adjacent, {x, y})
        |> Enum.reduce_while(0, fn {i, j}, acc ->
          cond do
            acc >= 4 -> {:halt, acc}
            at(grid, {i, j}) == @occupied -> {:cont, acc + 1}
            true -> {:cont, acc}
          end
        end)

      new_seat =
        case {seat, count} do
          {@occupied, 4} -> @empty
          {@empty, 0} -> @occupied
          _ -> seat
        end

      Map.put(acc, {x, y}, new_seat)
    end)
  end

  def precompute_adjacent(grid) do
    {rows, columns} = grid |> Map.keys() |> Enum.max()

    grid
    |> Enum.reduce(%{}, fn {{x, y}, _}, acc ->
      adj =
        @vectors
        |> Enum.map(fn {i, j} -> {x + i, y + j} end)
        |> Enum.filter(fn {i, j} -> i >= 0 && j >= 0 && i <= rows && j <= columns end)

      Map.put(acc, {x, y}, adj)
    end)
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
