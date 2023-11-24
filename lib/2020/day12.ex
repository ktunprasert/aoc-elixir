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

  def move_with_waypoint({code, unit}, pos, waypoint) do
    case code do
      "F" -> {traverse(pos, unit, waypoint), waypoint}
      "N" -> {pos, pos_move(waypoint, unit, :north)}
      "E" -> {pos, pos_move(waypoint, unit, :east)}
      "S" -> {pos, pos_move(waypoint, unit, :south)}
      "W" -> {pos, pos_move(waypoint, unit, :west)}
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

  def move({code, unit}, {n, e, s, w} = pos, facing) do
    direction =
      case facing do
        0 -> :north
        90 -> :east
        180 -> :south
        270 -> :west
      end

    case code do
      "F" -> {pos_move(pos, unit, direction), facing}
      "N" -> {pos_move(pos, unit, :north), facing}
      "E" -> {pos_move(pos, unit, :east), facing}
      "S" -> {pos_move(pos, unit, :south), facing}
      "W" -> {pos_move(pos, unit, :west), facing}
      "R" -> {{n, e, s, w}, rem(facing + unit, 360)}
      "L" -> {{n, e, s, w}, rem(facing - unit, 360)}
    end
    |> then(fn
      {pos, facing} when facing < 0 -> {pos, facing + 360}
      self -> self
    end)
  end

  def pos_move({n, e, s, w}, unit, :north), do: {n + unit, e, s, w}
  def pos_move({n, e, s, w}, unit, :east), do: {n, e + unit, s, w}
  def pos_move({n, e, s, w}, unit, :south), do: {n, e, s + unit, w}
  def pos_move({n, e, s, w}, unit, :west), do: {n, e, s, w + unit}

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn instruction ->
      {code, n} = instruction |> String.split_at(1)

      {code, String.to_integer(n)}
    end)
  end
end
