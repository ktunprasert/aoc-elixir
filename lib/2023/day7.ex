defmodule Aoc.Y2023.D7 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper
    |> Enum.map(fn [cards, bid] ->
      bitlist =
        cards
        |> String.to_charlist()
        |> Enum.map(fn
          ?A -> 14
          ?K -> 13
          ?Q -> 12
          ?J -> 11
          ?T -> 10
          c -> c - ?0
        end)

      [determine_kind(cards), bitlist, bid]
    end)
    |> Enum.sort()
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {[_kind, _, bid], idx}, acc ->
      acc + bid * idx
    end)
  end

  def part2(input) do
    input
    |> helper
    |> Enum.group_by(
      fn [cards, _] ->
        if String.contains?(cards, "J") do
          cards
          |> String.to_charlist()
          |> Enum.uniq()
          |> Enum.map(fn
            ?J -> determine_kind(cards)
            new_c -> determine_kind(String.replace(cards, "J", <<new_c>>))
          end)
          |> Enum.max()
        else
          determine_kind(cards)
        end
      end,
      fn [cards, bid] ->
        cards
        |> String.to_charlist()
        |> Enum.map(fn
          ?A -> 14
          ?K -> 13
          ?Q -> 12
          ?J -> 0
          ?T -> 10
          c -> c - ?0
        end)
        |> List.to_tuple()
        |> Tuple.append(bid)
      end
    )
    |> determine_rank_score()
  end

  def determine_rank_score(%{} = grouped) do
    grouped
    |> Enum.flat_map(fn {kind, lst} -> lst |> Enum.map(&Tuple.insert_at(&1, 0, kind)) end)
    |> Enum.sort()
    |> Enum.reduce({0, 1}, fn {_kind, _, _, _, _, _, bid}, {acc, idx} ->
      {acc + bid * idx, idx + 1}
    end)
    |> elem(0)
  end

  def determine_kind(cards) when is_binary(cards),
    do: determine_kind(cards |> String.to_charlist() |> Enum.sort(), 0)

  def determine_kind(cards), do: determine_kind(cards |> Enum.sort(), 0)
  def determine_kind([same, same, same, same, same], _), do: :"6_five"
  def determine_kind([same, same, same, same | _], _), do: :"5_four"
  def determine_kind([same, same, same, two, two], _), do: :"4_full"
  def determine_kind([two, two, same, same, same], _), do: :"4_full"
  def determine_kind([same, same, same | _], _), do: :"3_three"
  def determine_kind([same, same, two, two | _], _), do: :"2_two"
  def determine_kind([same, same | rest], num_pairs), do: determine_kind(rest, num_pairs + 1)
  def determine_kind([_same | rest], num_pairs), do: determine_kind(rest, num_pairs)
  def determine_kind([], 1), do: :"1_one"
  def determine_kind([], 2), do: :"2_two"
  def determine_kind([], _), do: :"0_high"

  def helper(input) do
    input
    |> parse_lines()
    |> Enum.map(fn line ->
      [cards, bid] = line |> String.split()
      [cards, String.to_integer(bid)]
    end)
  end
end
