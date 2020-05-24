defmodule NativeGraph.Service do
  @moduledoc """
  Module implementing graph store behaviour for native graphs.
  """
  @behaviour GraphCommons.Service
  use Agent
  import GraphCommons.Utils, only: [eval: 1]

  @dets_table 'priv/service/native/ex_graphs_book.dets'

  ## AGENT

  @spec start_link(GenServer.options()) :: :ok | {:error, term()}
  def start_link(_ex) do
    :dets.open_file(:ex_graphs_book, [{:file, @dets_table}])

    :dets.member(:ex_graphs_book, :graph)
    |> case do
      true ->
        [graph: g] = :dets.lookup(:ex_graphs_book, :graph)
        Agent.start_link(fn -> g end, name: __MODULE__)

      false ->
        Agent.start_link(fn -> %Graph{} end, name: __MODULE__)
    end
  end

  @spec stop() :: :ok | {:error, term()}
  def stop() do
    Agent.stop(__MODULE__)
    :dets.close(:ex_graphs_book)
  end

  ## BEHAVIOUR

  ## GRAPH

  @spec graph_create(GraphCommons.Graph.t()) :: :ok | {:error, term()}
  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  @spec graph_delete() :: :ok | {:error, term()}
  def graph_delete() do
    # Agent.update(__MODULE__, fn _state -> %Graph{} end)
    Agent.update(__MODULE__, fn _state -> NativeGraph.new_graph("Graph.new") end)
    :dets.delete(:ex_graphs_book, :graph)
  end

  @spec graph_read() :: Graph.t()
  def graph_read() do
    # Agent.get(__MODULE__, & &1)
    graph = Agent.get(__MODULE__, & &1)
    graph.data |> eval
  end

  @spec graph_update(GraphCommons.Graph.t()) :: :ok | {:error, term()}
  def graph_update(graph) do
    Agent.update(__MODULE__, fn _state -> graph end)
    :dets.insert(:ex_graphs_book, graph: graph)
  end

  ## INFO

  @spec graph_info() :: GraphCommons.Service.GraphInfo.t()
  def graph_info() do
    graph = Agent.get(__MODULE__, & &1)
    g = graph.data |> eval

    info = Graph.info(g)

    labels =
      Graph.vertices(g)
      |> Enum.reduce([], fn v, acc -> acc ++ Graph.vertex_labels(g, v) end)
      |> Enum.uniq()
      |> Enum.sort()

    %GraphCommons.Service.GraphInfo{
      type: :native,
      file: graph.file,
      num_nodes: info.num_vertices,
      num_edges: info.num_edges,
      labels: labels
    }
  end

  ## QUERY

  @spec query_graph(GraphCommons.Query.t()) :: {:ok, term()}
  def query_graph(%GraphCommons.Query{} = query) do
    :native = query.type
    result = eval("import Graph; import Enum; NativeGraph.graph_read |> (#{query.data})")
    {:ok, result}
  end

  @spec query_graph!(GraphCommons.Query.t()) :: term()
  def query_graph!(%GraphCommons.Query{} = query) do
    :native = query.type
    eval("import Graph; import Enum; import NativeGraph; graph_read() |> (#{query.data})")
  end
end
