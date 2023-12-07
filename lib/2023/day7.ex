defmodule Aoc.Y2023.D7 do
  use Aoc.Runner, inspect: true

  import Aoc.Util

  def part1(input) do
    input
    |> helper
    |> Enum.group_by(
      fn [cards, _bid] -> determine_kind(cards) end,
      fn [cards, bid] ->
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
        |> List.to_tuple()
        |> Tuple.append(bid)
      end
    )
    |> Enum.flat_map(fn {kind, lst} -> lst |> Enum.map(&Tuple.insert_at(&1, 0, kind)) end)
    |> Enum.sort()
    |> Enum.reduce({0, 1}, fn {_kind, _, _, _, _, _, bid}, {acc, idx} ->
      {acc + bid * idx, idx + 1}
    end)
    |> elem(0)
  end

  def part2(input) do
    input
    |> helper
    |> Enum.group_by(
      fn [cards, _] ->
        if String.contains?(cards, "J") do
          cards_chars = cards |> String.to_charlist()

          cards_chars
          |> Enum.uniq()
          |> Enum.flat_map(fn new_c ->
            [replace_with(cards_chars, new_c, []) |> determine_kind()]
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
    |> Enum.flat_map(fn {kind, lst} -> lst |> Enum.map(&Tuple.insert_at(&1, 0, kind)) end)
    |> Enum.sort()
    |> Enum.reduce({0, 1}, fn {_kind, _, _, _, _, _, bid}, {acc, idx} ->
      {acc + bid * idx, idx + 1}
    end)
    |> elem(0)
  end

  def replace_with([], _new, acc), do: acc
  def replace_with([?J | cards], new, acc), do: replace_with(cards, new, [new | acc])
  def replace_with([c | cards], new, acc), do: replace_with(cards, new, [c | acc])

  # @faces [?A, ?K, ?Q, ?J, ?T | Enum.to_list(?9..?2)]
  # @faces_joker [?A, ?K, ?Q, ?T | Enum.to_list(?9..?2)]
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
