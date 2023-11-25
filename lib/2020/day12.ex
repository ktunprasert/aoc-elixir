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

  def manhattan({{n, e, s, w}, _}), do: abs(n - s) + abs(e - w)

  def move_with_waypoint({code, unit}, pos, waypoint) do
    case code do
      "F" -> {pos +++ (waypoint ~> unit), waypoint}
      "N" -> {pos, waypoint +++ {unit, 0, 0, 0}}
      "E" -> {pos, waypoint +++ {0, unit, 0, 0}}
      "S" -> {pos, waypoint +++ {0, 0, unit, 0}}
      "W" -> {pos, waypoint +++ {0, 0, 0, unit}}
      "R" -> {pos, rotate(waypoint, unit, true)}
      "L" -> {pos, rotate(waypoint, unit, false)}
    end
  end

  def rotate({n, e, s, w}, rotation, clockwise) do
    rotation = if clockwise, do: rotation, else: 360 - rotation

    case rotation do
      90 -> {w, n, e, s}
      180 -> {s, w, n, e}
      270 -> {e, s, w, n}
    end
  end

  def move({code, unit}, pos, facing) do
    direction =
      case facing do
        0 -> {unit, 0, 0, 0}
        90 -> {0, unit, 0, 0}
        180 -> {0, 0, unit, 0}
        270 -> {0, 0, 0, unit}
      end

    case code do
      "F" -> {pos +++ direction, facing}
      "N" -> {pos +++ {unit, 0, 0, 0}, facing}
      "E" -> {pos +++ {0, unit, 0, 0}, facing}
      "S" -> {pos +++ {0, 0, unit, 0}, facing}
      "W" -> {pos +++ {0, 0, 0, unit}, facing}
      "R" -> {pos, rem(facing + unit + 360, 360)}
      "L" -> {pos, rem(facing - unit + 360, 360)}
    end
  end

  def {a, b, c, d} +++ {w, x, y, z}, do: {a + w, b + x, c + y, d + z}

  def {a, b, c, d} ~> factor, do: {a * factor, b * factor, c * factor, d * factor}

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn instruction ->
      {code, n} = instruction |> String.split_at(1)

      {code, String.to_integer(n)}
    end)
  end
end
