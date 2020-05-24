defmodule PropertyGraph.MixProject do
  use Mix.Project

  def project do
    [
      app: :property_graph,
      version: "0.1.0",
      description: "ExGraphsBook - Property graph functions.",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      # mod: {PropertyGraph.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},

      # graph_commons
      {:graph_commons, in_umbrella: true},

      # property graphs
      # {:bolt_sips, "~> 1.5"}
      # {:bolt_sips, git: "https://github.com/florinpatrascu/bolt_sips.git"},
      {:bolt_sips, "~> 2.0.0-rc"}
      # {:jason, "~> 1.1"}
    ]
  end
end
