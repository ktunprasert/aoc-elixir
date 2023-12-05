defmodule Aoc.Y2023.D5 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    [seeds | pipelines] =
      input
      |> helper()

    seeds =
      seeds
      |> String.split()
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)

    pipelines
    |> Enum.map(fn mapstr ->
      mapstr
      |> String.split()
      |> Enum.drop(2)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(3)
      |> Enum.map(fn [a, b, c] ->
        fn i ->
          if i in b..(b + c - 1) do
            a + (i - b)
          else
            nil
          end
        end
      end)
    end)
    |> Enum.reduce(seeds, fn pipe_fns, seeds ->
      seeds
      |> Enum.map(fn seed ->
        case Enum.map(pipe_fns, & &1.(seed))
             |> Enum.find_value(nil, fn x ->
               if x != nil do
                 x
               else
                 false
               end
             end) do
          nil -> seed
          found -> found
        end
      end)
    end)
    |> Enum.min()
  end

  def part2(input) do
    [seeds | pipelines] =
      input
      |> helper()

    seeds =
      seeds
      |> String.split()
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.flat_map(fn [a, b] -> a..(a + b - 1) |> Enum.to_list() end)

    pipelines
    |> Enum.map(fn mapstr ->
      mapstr
      |> String.split()
      |> Enum.drop(2)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(3)
      |> Enum.map(fn [a, b, c] ->
        fn i ->
          if i in b..(b + c - 1) do
            a + (i - b)
          else
            nil
          end
        end
      end)
    end)
    |> Enum.reduce(seeds, fn pipe_fns, seeds ->
      seeds
      |> Enum.map(fn seed ->
        Enum.reduce_while(pipe_fns, seed, fn f, acc ->
          case f.(seed) do
            nil -> {:cont, acc}
            found -> {:halt, found}
          end
        end)
      end)
    end)
    |> Enum.min()
  end

  def helper(input) do
    input |> parse_lines("\n\n")
  end
end
