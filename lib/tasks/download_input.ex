defmodule Mix.Tasks.Download do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    [year, day] = args

    Mix.Task.run("app.start")

    cookie = Dotenv.get("AOC_SESSION")

    res = Req.get!("https://adventofcode.com/#{year}/day/#{day}/input",
      headers: [
        {"Cookie", "session=#{cookie}"}
      ]
    )

    filename = "priv/inputs/#{year}/day#{day}.txt"

    File.write(filename, res.body)

    IO.puts("Downloaded input for day #{day} of year #{year} to #{filename}")
  end
end
