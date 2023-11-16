defmodule Aoc.Y2020.D4 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @required ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  def part1(input) do
    passports =
      helper(input)
      |> Enum.map(fn passport ->
        passport
        |> String.split(" ")
        |> Enum.map(&(&1 |> String.split(":") |> List.to_tuple()))
        |> Enum.into(%{})
      end)

    passports
    |> Enum.count(fn passport ->
      @required |> Enum.all?(fn key -> Map.has_key?(passport, key) end)
    end)
  end

  def part2(input) do
    :ok
  end

  def helper(input) do
    input |> parse_lines("\n\n") |> Enum.map(&String.replace(&1, ~r/[\s]/, " "))
  end
end
