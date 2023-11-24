defmodule Aoc.Y2020.D12 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    instructions = helper(input)

    # North, East, South, West
    start = {0, 0, 0, 0}
    facing = 90

    instructions
    |> Enum.reduce({start, facing}, fn instruction, {prev, facing} ->
      move(instruction, prev, facing)
    end)
    |> manhattan()
  end

  def part2(input) do
    instructions = helper(input)

    # North, East, South, West
    start = {0, 0, 0, 0}
    waypoint = {1, 10, 0, 0}

    instructions
    |> Enum.reduce({start, waypoint}, fn instruction, {prev, waypoint} ->
      move_with_waypoint(instruction, prev, waypoint)
    end)
    |> manhattan()
  end

  def manhattan({{n, e, s, w}, _}) do
    abs(n - s) + abs(e - w)
  end

  def move_with_waypoint({code, unit}, pos, {wn, we, ws, ww} = waypoint) do
    case code do
      "F" -> {traverse(pos, unit, waypoint), waypoint}
      "N" -> {pos, {wn + unit, we, ws, ww}}
      "E" -> {pos, {wn, we + unit, ws, ww}}
      "S" -> {pos, {wn, we, ws + unit, ww}}
      "W" -> {pos, {wn, we, ws, ww + unit}}
      "R" -> {pos, rotate(waypoint, unit, true)}
      "L" -> {pos, rotate(waypoint, unit, false)}
    end
  end

  def traverse({n, e, s, w}, factor, {wn, we, ws, ww}) do
    {n + wn * factor, e + we * factor, s + ws * factor, w + ww * factor}
  end

  def rotate({n, e, s, w} = pos, rotation, clockwise) do
    rotation = if clockwise, do: rotation, else: 360 - rotation

    case rotation do
      90 -> {w, n, e, s}
      180 -> {s, w, n, e}
      270 -> {e, s, w, n}
      _ -> pos
    end
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
