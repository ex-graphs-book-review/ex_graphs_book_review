defmodule NativeGraph do
  @moduledoc """
  Module for reading and writing a library of `libgraph` graphs.

  The `read_graph/1` and `write_graph/2` functions allow for reading and writing
  RDF graphs to the project data repository. (Default file names are provided
  with the `read_graph/0` and `write_graph/1` forms.) The `list_graphs/0`
  function lists graph file names.

  ## Examples

      iex> NativeGraph.read_graph("default.graph")
      #GraphCommons.Graph<type: native, file: "default.graph", data: "Graph.new |> Gra...">

      iex> "..." |> NativeGraph.write_graph("my.test")
      #GraphCommons.Graph<type: native, file: "my.test", data: "...">
  """

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :native, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :native, query_module: __MODULE__

  ## GRAPH SERVICE

  @doc "Delegates to NativeGraph.Service.graph_create/1"
  defdelegate graph_create(arg), to: NativeGraph.Service, as: :graph_create
  @doc "Delegates to NativeGraph.Service.graph_delete/0"
  defdelegate graph_delete(), to: NativeGraph.Service, as: :graph_delete
  @doc "Delegates to NativeGraph.Service.graph_info/0"
  defdelegate graph_info(), to: NativeGraph.Service, as: :graph_info
  @doc "Delegates to NativeGraph.Service.graph_read/0"
  defdelegate graph_read(), to: NativeGraph.Service, as: :graph_read
  @doc "Delegates to NativeGraph.Service.graph_update/1"
  defdelegate graph_update(arg), to: NativeGraph.Service, as: :graph_update

  @doc "Delegates to NativeGraph.Service.query_graph/1"
  defdelegate query_graph(arg), to: NativeGraph.Service, as: :query_graph
  @doc "Delegates to NativeGraph.Service.query_graph!/1"
  defdelegate query_graph!(arg), to: NativeGraph.Service, as: :query_graph!

  ## WRITE IMAGE

  @doc "Delegates to NativeGraph.Format.to_png/1"
  defdelegate write_image(arg), to: NativeGraph.Format, as: :to_png
  @doc "Delegates to NativeGraph.Format.to_png/2"
  defdelegate write_image(arg1, arg2), to: NativeGraph.Format, as: :to_png
  @doc "Delegates to NativeGraph.Builder.random_graph/1"
  defdelegate random_graph(arg), to: NativeGraph.Builder, as: :random_graph

  ## TODO

  defdelegate to_dot(arg), to: NativeGraph.Serializers.DOT, as: :serialize
  defdelegate to_dot!(arg), to: NativeGraph.Serializers.DOT, as: :serialize!
  # @spec to_dot(t) :: {:ok, binary} | {:error, term}
  # def to_dot(%__MODULE__{} = g) do
  #   NativeGraph.Serializers.DOT.serialize(g)
  # end


  # @doc ~S"""
  # Writes a native graph in DOT format to a file in the native graphs library.
  #
  # ## Examples
  #
  #     iex> NativeGraph.read_graph("books.graph").data |>
  #     ...> NativeGraph.write_dot_graph("dot/books.dot")
  #     #GraphCommons.Graph<type: native, file: "dot/books.dot", data: "strict digraph {...">
  # """
  # @spec write_dot_graph(graph_data, graph_file) :: graph_t
  # def write_dot_graph(graph_data, graph_file \\ temp_graph_file()) do
  #   {g, _} = Code.eval_string(graph_data)
  #   {:ok, graph_data} = g |> Graph.to_dot()
  #   graph_data |> GraphCommons.Graph.write_graph(graph_file, :native)
  #   # with
  #   #   {g, _} <- Code.eval_string(graph_data),
  #   #   {:ok, graph_data} <-  Graph.to_dot(g)
  #   # do
  #   #   graph_data |> GraphCommons.Graph.write_graph(graph_file, :native)
  #   # end
  # end

  # def eval_graph(graph_file \\ graph_file()) do
  #   GraphCommons.Graph.read_graph(graph_file, :native).data
  #   |>  Code.eval_string |> elem(0)
  # end
  #

  # results = NativeGraph.read_graph("books.graph").data |> Code.eval_string |> elem(0) |> Graph.to_dot
  # with {:ok, a} <- results, do: NativeGraph.write_graph(a, "books.dot")
  #  NativeGraph.read_graph("books.dot") |> NativeGraph.to_png
end
