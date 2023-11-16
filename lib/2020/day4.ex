defmodule Aoc.Y2020.D4 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  @required ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  def part1(input) do
    passports = helper(input)

    passports
    |> Enum.count(fn passport ->
      @required |> Enum.all?(fn key -> Map.has_key?(passport, key) end)
    end)
  end

  def part2(input) do
    passports = helper(input)

    passports
    |> Enum.count(fn passport ->
      Enum.all?(@required, fn key ->
        case Map.get(passport, key) do
          nil -> false
          value -> is_valid(key, value)
        end
      end)
    end)
  end

  def is_valid("byr", year), do: year |> String.to_integer() |> then(&(&1 >= 1920 and &1 <= 2002))
  def is_valid("iyr", year), do: year |> String.to_integer() |> then(&(&1 >= 2010 and &1 <= 2020))
  def is_valid("eyr", year), do: year |> String.to_integer() |> then(&(&1 >= 2020 and &1 <= 2030))

  def is_valid("hgt", height) do
    case Regex.run(~r/(\d+)(cm|in)/, height) do
      [_, height, "cm"] -> height |> String.to_integer() |> then(&(&1 >= 150 and &1 <= 193))
      [_, height, "in"] -> height |> String.to_integer() |> then(&(&1 >= 59 and &1 <= 76))
      _ -> false
    end
  end

  def is_valid("hcl", color), do: Regex.match?(~r/^#[0-9a-f]{6}$/, color)
  def is_valid("ecl", color), do: color in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
  def is_valid("pid", id), do: Regex.match?(~r/^\d{9}$/, id)
  def is_valid("cid", _), do: true

  def helper(input) do
    input
    |> parse_lines("\n\n")
    |> Enum.map(&String.replace(&1, ~r/[\s]/, " "))
    |> Enum.map(fn passport ->
      passport
      |> String.split(" ")
      |> Enum.map(&(&1 |> String.split(":") |> List.to_tuple()))
      |> Enum.into(%{})
    end)
  end
end
