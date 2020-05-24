defmodule PropertyGraph.Service do
  @moduledoc """
  Module implementing graph store behaviour for property graphs.
  """
  @behaviour GraphCommons.Service

  # import PropertyGraph, only: [read_query: 0, read_query: 1]
  # import PropertyGraph.Client

  @cypher_delete """
  MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r
  """

  @cypher_read """
  MATCH (n) OPTIONAL MATCH (n)-[r]-() RETURN DISTINCT n, r
  """

  # @cypher_info "CALL apoc.meta.stats YIELD stats"
  @cypher_info """
  CALL apoc.meta.stats()
  YIELD labels, labelCount, nodeCount, relCount, relTypeCount
  """

  # @cypher_counts """
  # MATCH (n) OPTIONAL MATCH p = (n)-[r]-()
  # RETURN
  # count(distinct n) as nodes,
  # count(distinct r) as relationships,
  # count(distinct p) as paths
  # """

  ## GRAPH

  @spec graph_create(GraphCommons.Graph.t()) :: any
  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  @spec graph_delete() :: any
  def graph_delete(), do: Bolt.Sips.query!(Bolt.Sips.conn(), @cypher_delete)

  @spec graph_info() :: any
  def graph_info() do
    # Bolt.Sips.query!(Bolt.Sips.conn(), @cypher_info)
    {:ok, [stats]} =
      @cypher_info
      |> PropertyGraph.new_query()
      |> query_graph

    %GraphCommons.Service.GraphInfo{
      type: :property,
      file: "",
      num_nodes: stats["nodeCount"],
      num_edges: stats["relCount"],
      # density: _density(stats["nodeCount"], stats["relCount"]),
      labels: Map.keys(stats["labels"])
    }
  end

  # def _density(n, m) do
  #   if n > 0, do: Float.round(m / (n * (n - 1)), 3), else: 0.0
  # end

  @spec graph_read() :: any
  def graph_read(), do: Bolt.Sips.query!(Bolt.Sips.conn(), @cypher_read)

  @spec graph_update(GraphCommons.Graph.t()) :: any
  def graph_update(%GraphCommons.Graph{} = graph),
    do: Bolt.Sips.query!(Bolt.Sips.conn(), graph.data)

  ## QUERY

  @spec query_graph(GraphCommons.Query.t()) :: any
  def query_graph(%GraphCommons.Query{} = query), do: query_graph(query, %{})

  @spec query_graph!(GraphCommons.Query.t()) :: any
  def query_graph!(%GraphCommons.Query{} = query), do: query_graph!(query, %{})

  @spec query_graph(GraphCommons.Query.t()) :: any
  def query_graph(%GraphCommons.Query{} = query, params) do
    :property = query.type

    Bolt.Sips.query(Bolt.Sips.conn(), query.data, params)
    |> case do
      {:ok, response} -> _parse_response(response, false)
      {:error, error} -> {:error, error}
    end
  end

  @spec query_graph!(GraphCommons.Query.t()) :: any
  def query_graph!(%GraphCommons.Query{} = query, params) do
    :property = query.type

    Bolt.Sips.query(Bolt.Sips.conn(), query.data, params)
    |> case do
      {:ok, response} -> _parse_response(response, true)
      {:error, error} -> raise "! #{inspect error}"
    end
  end

  defp _parse_response(%Bolt.Sips.Response{} = response, bang) do
    %Bolt.Sips.Response{type: type} = response

    case type do
      r when r in ["r", "rw"] ->
        %Bolt.Sips.Response{results: results} = response
        unless bang, do: {:ok, results}, else: results

      w when w in ["s", "w"] ->
        %Bolt.Sips.Response{stats: stats} = response
        unless bang, do: {:ok, stats}, else: stats
    end
  end

end
