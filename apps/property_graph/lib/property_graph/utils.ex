defmodule PropertyGraph.Utils do
  @moduledoc """
  Module providing helper functions.
  """

  @storage_dir GraphCommons.storage_dir()

  @graphgists_dir @storage_dir <> "/property/graphgists/"
  @test_graphgist_file "template.adoc"

  ## graphgists

  @doc """
  Reads a graphgist from the graphgists library.

  ## Examples

      iex> read_graphgist("template.adoc")
      "= REPLACEME: TITLE OF YOUR GRAPHGIST\\n:neo4j-version: 2.3.0\\n:author:" <> ...

  """
  def read_graphgist(graphgist_file \\ @test_graphgist_file) do
    File.read!(@graphgists_dir <> graphgist_file)
  end

  @doc """
  Parses a graphgist to return a Cypher graph.

  ## Examples

      iex> parse(read_graphgist())
      "CREATE\\n  (a:Person {name: 'Alice'}),\\n  (b:Person {name: 'Bob'}),\\n" <> ...

  """
  def parse(graphgist) do
    ~r/\/setup\n(\/\/hide\n)*(\/\/output\n)*\[source,\s*cypher\]\n\-\-\-\-.*\n((.|\n)*)\-\-\-\-.*\n/Um
    |> Regex.run(graphgist)
    |> case do
      # //hide\n
      [_, cypher, _] -> cypher
      # //hide\n//output]\n
      [_, _, cypher, _] -> cypher
      [_, _, _, cypher, _] -> cypher
      _ -> ""
    end
  end
end
