defmodule Speechmatex.Mixfile do
  use Mix.Project

  def project do
    [app: :speechmatex,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.travis": :test]]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:meck, "~> 0.8.4", only: :test},
     {:httpoison, "~> 0.11.1"},
     {:poison, "~> 3.1"},
     {:excoveralls, "~> 0.6.3", only: :test}]
  end
end
