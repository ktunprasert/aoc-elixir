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
      maps =
        mapstr
        |> String.split()
        |> Enum.drop(2)
        |> Enum.map(&String.to_integer/1)
        |> Enum.chunk_every(3)

      maps
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
        case Enum.map(pipe_fns, & &1.(seed)) |> Enum.filter(&(&1 != nil)) do
          [found] -> found
          [] -> seed
        end
      end)
    end)
    |> Enum.min()
  end

  def part2(input) do
    :ok
  end

  # def apply_pipeline(seed, pipeline) do
  # end

  def parse_int(line), do: parse_int(line, [])

  def parse_int(<<>>, acc), do: acc |> Enum.reverse()

  def parse_int(<<a, sp, rest::binary>>, acc) when a in ?0..?9 and sp in [?\s, ?\n],
    do: parse_int(rest, [a - ?0 | acc])

  def parse_int(<<a, b, sp, rest::binary>>, acc) when a in ?0..?9 and sp in [?\s, ?\n],
    do: parse_int(rest, [(a - ?0) * 10 + b - ?0 | acc])

  def parse_int(<<a, b, rest::binary>>, acc) when a in ?0..?9,
    do: parse_int(rest, [(a - ?0) * 10 + b - ?0 | acc])

  def parse_int(<<a, rest::binary>>, acc) when a in ?0..?9,
    do: parse_int(rest, [a - ?0 | acc])

  def parse_int(<<_, rest::binary>>, acc), do: parse_int(rest, acc)

  def helper(input) do
    input |> parse_lines("\n\n")
  end
end
