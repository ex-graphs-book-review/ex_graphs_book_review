defmodule ExGraphsBook.MixProject do
  use Mix.Project

  def project do
    [
      aliases: aliases(),
      apps_path: "apps",
      apps: [
        :graph_commons,
        :native_graph,
        :property_graph,
        :rdf_graph
      ],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
      # dialyzer: [ignore_warnings: "dialyzer.ignore-warnings"]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp aliases do
    [
      test_graph_commons: "cmd --app graph_commons mix test --color",
      test_native_graph: "cmd --app native_graph mix test --color",
      test_property_graph: "cmd --app property_graph mix test --color",
      test_rdf_graph: "cmd --app rdf_graph mix test --color"
    ]
  end
end
