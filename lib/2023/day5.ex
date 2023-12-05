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
        {a, b..(b + c - 1), b}
      end)
      |> chained(fn i -> i end)
    end)
    |> Enum.reduce(seeds, fn f, seeds ->
      seeds
      |> Enum.map(&f.(&1))
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
        {a, b..(b + c - 1), b}
      end)
      |> Enum.sort()
    end)
    |> Enum.reduce(seeds, fn pipe_tuples, seeds ->
      seeds
      |> Enum.map(fn seed ->
        Enum.reduce_while(pipe_tuples, seed, fn {a, range, b}, seed ->
          if seed in range do
            {:halt, a + (seed - b)}
          else
            {:cont, seed}
          end
        end)
      end)
    end)
    |> Enum.min()
  end

  def chained([], fn_acc), do: fn_acc

  def chained([{a, range, b} | fns], fn_acc) do
    chained(fns, fn i ->
      if i in range do
        a + (i - b)
      else
        fn_acc.(i)
      end
    end)
  end

  def helper(input) do
    input |> parse_lines("\n\n")
  end
end
