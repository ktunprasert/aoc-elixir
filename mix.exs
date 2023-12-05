defmodule Aoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.15",
      # start_permanent: Mix.env() == :prod,
      start_concurrently: true,
      start_permanent: true,
      deps: deps(),
      escript: escript(),
      releases: [
        demo: [
          include_executables_for: [:unix],
          applications: [runtime_tools: :permanent],
          # steps: [:assemble, :tar]
        ]
      ]
    ]
  end

  def escript do
    [
      main_module: Aoc.Main
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.4.0"},
      {:dotenv, "~> 3.1.0", only: [:dev, :test]},
      {:benchee, "~> 1.0", only: :dev}
    ]
  end
end
