defmodule Aoc.Y2020.D12 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    instructions = helper(input)

    # North, East, South, West
    start = {0, 0, 0, 0}
    facing = 90

    instructions
    |> Enum.reduce({start, facing}, fn {code, unit}, {prev, facing} ->
      move({code, unit}, prev, facing)
    end)
    |> manhattan()
  end

  def part2(input) do
    :ok
  end

  def manhattan({{n, e, s, w}, _}) do
    abs(n - s) + abs(e - w)
  end

  def move({code, unit}, {n, e, s, w}, facing) do
    case code do
      "F" ->
        case facing do
          0 -> {{n + unit, e, s, w}, facing}
          90 -> {{n, e + unit, s, w}, facing}
          180 -> {{n, e, s + unit, w}, facing}
          270 -> {{n, e, s, w + unit}, facing}
        end

      "N" ->
        {{n + unit, e, s, w}, facing}

      "E" ->
        {{n, e + unit, s, w}, facing}

      "S" ->
        {{n, e, s + unit, w}, facing}

      "W" ->
        {{n, e, s, w + unit}, facing}

      "R" ->
        {{n, e, s, w}, rem(facing + unit, 360)}

      "L" ->
        {{n, e, s, w}, rem(facing - unit, 360)}
    end
    |> then(fn
      {pos, facing} when facing < 0 -> {pos, facing + 360}
      self -> self
    end)
  end

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn instruction ->
      {code, n} = instruction |> String.split_at(1)

      {code, String.to_integer(n)}
    end)
  end
end
