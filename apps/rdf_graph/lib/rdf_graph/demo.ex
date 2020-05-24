defmodule RDFGraph.Demo do
  @moduledoc """
  This module provides test functions for the SPARQL.Client module.
  """

  import RDFGraph

  @queries_dir "hurricanes/"

  @service "http://dbpedia.org/sparql"

  ## Demo of multiple SPARQL queries: from RQ files to ETS tables

  @doc """
  """
  def demo() do
    # get list of query files
    query_files = list_queries_dir(@queries_dir)
    for query_file <- query_files,
      do: _read_query(query_file) |> _get_data
  end

  defp _read_query(query_file) do
    # output a progress update
    IO.puts "Reading #{query_file}"

    # read query from query_file
    query = read_query(@queries_dir <> query_file).data
    {query, Module.concat(__MODULE__, Path.basename(query_file, ".rq"))}
  end

  defp _get_data({query, table_name}),
    do: _get_data(query, table_name)

  defp _get_data(query, table_name) do
    # output a progress update
    IO.puts "Writing #{table_name}"

    # create ETS table
    :ets.new(table_name, [:named_table])

    # now call SPARQL endpoint and populate ETS table
    case SPARQL.Client.query(query, @service) do
    # case query_graph(new_query(query)) do
      {:ok, result} ->
        result.results |> Enum.each(
          fn t -> :ets.insert(table_name, _build_spo_tuple(t)) end
        )
      {:error, reason} ->
        raise "! Error: #{reason}"
    end
  end

  defp _build_spo_tuple(t) do
    s = t["s"].value
    p = t["p"].value
    # need to test type of object term
    o =
      case t["o"] do
        %RDF.IRI{} -> t["o"].value
        %RDF.Literal{} -> t["o"].value
        %RDF.BlankNode{} -> t["o"].id
        _ -> raise "! Error: Could not get type of object term"
      end
    {System.os_time(), s, p, o, t}
  end

  ##

  @doc """
  Reads RDF data from ETS table and returns RDF.Graph.
  """
  def read_table(table_name) do
    g = RDF.Graph.new()

    :ets.tab2list(table_name)
    |> Enum.reduce(
      g,
      fn tuple, g ->
        g
        |> RDF.Graph.add(_read_tuple(tuple))
      end
    )
  end

  defp _read_tuple({_, s, p, o, _}),
    do: RDF.triple(s, p, o)

end
