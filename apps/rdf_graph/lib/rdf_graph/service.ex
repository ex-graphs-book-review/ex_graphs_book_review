defmodule RDFGraph.Service do
  @moduledoc """
  Module implementing graph store behaviour for RDF graphs.
  """
  @behaviour GraphCommons.Service

  @sparql_count_nodes """
  SELECT (count(DISTINCT ?vertex) AS ?total)
  WHERE
  {
    {
      ?vertex ?p []
    }
    UNION
    {
      [] ?p ?vertex
      FILTER(!IsLiteral(?vertex))
    }
  }
  """

  # SELECT (count(DISTINCT ?edge) AS ?total)
  @sparql_count_edges """
  SELECT (count(?vertex) AS ?total)
  WHERE
  {
    {
      ?vertex ?edge []
    }
  }
  """

  @sparql_list_types """
  SELECT distinct ?type
  WHERE
  {
    {
      ?vertex a ?type
    }
  }
  """

  ## STORE
  def rdf_store do
    Application.get_env(:rdf_graph, :rdf_store)
  end
  def rdf_store(store) do
    Application.put_env(:rdf_graph, :rdf_store, store )
  end
  def list_rdf_stores do
    Map.keys Application.get_env(:rdf_graph, :graph_store)
  end
  def rdf_store_admin do
    store = rdf_store()
    Application.get_env(:rdf_graph, :graph_store)[store][:admin]
  end
  def rdf_store_query do
    store = rdf_store()
    Application.get_env(:rdf_graph, :graph_store)[store][:query]
  end

  ## GRAPH

  @spec graph_create(GraphCommons.Graph.t()) :: any
  def graph_create(%GraphCommons.Graph{} = graph) do
    if rdf_store_admin() do
      graph_delete()
      graph_update(graph)
    else
      {:error, rdf_store()}
    end
  end

  @spec graph_delete() :: any
  def graph_delete() do
    if rdf_store_admin() do
      {:ok, env} = Tesla.delete(rdf_store_admin())
      GraphCommons.Graph.new(env.body, "", :rdf)
      env
    else
      {:error, rdf_store()}
    end
  end

  @spec graph_info() :: any
  def graph_info() do
    import RDFGraph, only: [new_query: 1]
    if rdf_store_admin() do

      {:ok, %SPARQL.Query.Result{results: [%{"total" => total}]}} =
        @sparql_count_nodes
        |> new_query
        |> query_graph

      nodes = Integer.parse(total.value) |> elem(0)

      {:ok, %SPARQL.Query.Result{results: [%{"total" => total}]}} =
        @sparql_count_edges
        |> new_query
        |> query_graph

      edges = Integer.parse(total.value) |> elem(0)

      {:ok, %SPARQL.Query.Result{results: types}} =
        @sparql_list_types
        |> new_query
        |> query_graph

      labels =
        types
        |> Enum.map(fn t ->
          %{"type" => type} = t
          # URI.parse(type.value).path
          URI.parse(type.value).path |> Path.basename
        end)
        |> Enum.sort

      %GraphCommons.Service.GraphInfo{
        type: :rdf,
        file: "",
        num_nodes: nodes,
        num_edges: edges,
        # density: _density(nodes, edges),
        labels: labels
      }
    else
      {:ok, rdf_store()}
    end
  end

  # def _density(n, m) do
  #   if n > 0, do: Float.round(m / (n * (n - 1)), 3), else: 0.0
  # end

  @spec graph_read() :: any
  def graph_read() do
    if rdf_store_admin() do
      {:ok, env} = Tesla.get(rdf_store_admin())
      GraphCommons.Graph.new(env.body, "", :rdf)
    else
      {:error, rdf_store()}
    end
  end

  @spec graph_update(GraphCommons.Graph.t()) :: any
  def graph_update(%GraphCommons.Graph{} = graph) do
    if rdf_store_admin() do
      {:ok, env} = Tesla.post(rdf_store_admin(), graph.data, headers: [{"content-type", "text/turtle"}])
      GraphCommons.Graph.new(env.body, "", :rdf)
    else
      {:error, rdf_store()}
    end
  end

  ## QUERY

  @spec query_graph(GraphCommons.Query.t()) :: any
  def query_graph(%GraphCommons.Query{} = query) do
    :rdf = query.type
    SPARQL.Client.query(query.data, rdf_store_query())
  end

  @spec query_graph!(GraphCommons.Query.t()) :: any
  def query_graph!(%GraphCommons.Query{} = query) do
    :rdf = query.type

    SPARQL.Client.query(query.data, rdf_store_query())
    |> case do
      {:ok, response} -> response
      {:error, message} -> raise "! #{message}"
    end
  end

  # @spec query_graph!(GraphCommons.Query.t()) :: any
  # def query_graph!(%GraphCommons.Query{} = query, options \\ %{}) do
  #   :rdf = query.type
  #
  #   SPARQL.Client.query(query.data, rdf_store_query(), options)
  #   |> case do
  #     {:ok, response} -> response
  #     {:error, message} -> raise "! #{message}"
  #   end
  # end

  def query_graph(%GraphCommons.Query{} = query, params) do
    data = query.data
    params |> Map.keys |> Enum.each(
      fn key ->
        String.replace(data, key, Map.get(params, key))
      end
    )
    IO.inspect data
    query_graph(query)
  end

end
