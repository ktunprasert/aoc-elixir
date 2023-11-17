defmodule Aoc.Runner do
  def run(year, day, part \\ nil) do
    module = "Elixir.Aoc.Y#{year}.D#{day}" |> String.to_existing_atom()

    if part do
      apply(module, :run, [part])
    else
      apply(module, :run, [])
    end
  end

  defmacro __using__(opts) do
    inspect? = Keyword.get(opts, :inspect, false)

    quote do
      def run() do
        part1 = run_part1()
        part2 = run_part2()

        if unquote(inspect?) do
          part1 |> IO.inspect(label: "Part 1")
          part2 |> IO.inspect(label: "Part 2")
        end

        :ok
      end

      def run(1), do: run_part1()
      def run(2), do: run_part2()

      def run_part1() do
        part1(get_input())
      end

      def run_part2() do
        part2(get_input())
      end

      defp get_input() do
        module_name = to_string(__MODULE__)
        [year, day] = parse_module_name(module_name)
        input_path = "/priv/inputs/#{year}/day#{day}.txt"

        if !File.exists?(File.cwd!() <> input_path) do
          nil
        else
          File.read!(File.cwd!() <> input_path)
        end
      end

      def parse_module_name(module_name) do
        module_name
        |> String.split(".")
        |> Enum.take(-2)
        |> Enum.map(&grab_digits/1)
      end

      def grab_digits(string) do
        case Regex.run(~r/\d+/, string) do
          lst when is_list(lst) -> lst |> List.first()
          nil -> nil
        end
      end
    end
  end
end
