defmodule RDFGraph.MixProject do
  use Mix.Project

  def project do
    [
      app: :rdf_graph,
      version: "0.1.0",
      description: "ExGraphsBook - RDF graph functions.",
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
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},

      # graph_commons
      {:graph_commons, in_umbrella: true},

      # rdf graphs
      {:sparql_client, "~> 0.2"},
      {:hackney, "~> 1.15"}
    ]
  end
end
