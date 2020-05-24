defmodule RDFGraph do
  @moduledoc """
    Module for reading and writing a library of RDF graphs and SPARQL queries.

    The `read_graph/1` and `write_graph/2` functions allow for reading and writing
    RDF graphs to the project data repository. (Default file names are provided
    with the `read_graph/0` and `write_graph/1` forms.) The `list_graphs/0`
    function lists graph file names.

    The `read_query/1` and `write_query/2` functions allow for reading and writing
    SPARQL queries to the project data repository. (Default file names are
    provided with the `read_query/0` and `write_query/1` forms.) The
    `list_queries/0` function lists query file names.

    ## Examples

        iex> RDFGraph.read_graph("default.ttl")
        #GraphCommons.Graph<type: rdf, file: "default.ttl", data: "@prefix ns: <htt...">

        iex> "..." |> RDFGraph.write_graph("my.test")
        #GraphCommons.Graph<type: rdf, file: "my.test", data: "...">
  """

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :rdf, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :rdf, query_module: __MODULE__

  ## GRAPH SERVICE

  @doc "Delegates to RDFGraph.Service.graph_create/1"
  defdelegate graph_create(arg), to: RDFGraph.Service, as: :graph_create
  @doc "Delegates to RDFGraph.Service.graph_delete/0"
  defdelegate graph_delete(), to: RDFGraph.Service, as: :graph_delete
  @doc "Delegates to RDFGraph.Service.graph_read/0"
  defdelegate graph_info(), to: RDFGraph.Service, as: :graph_info
  @doc "Delegates to RDFGraph.Service.graph_info/0"
  defdelegate graph_read(), to: RDFGraph.Service, as: :graph_read
  @doc "Delegates to RDFGraph.Service.graph_update/1"
  defdelegate graph_update(arg), to: RDFGraph.Service, as: :graph_update

  @doc "Delegates to RDFGraph.Service.query_graph/1"
  defdelegate query_graph(arg), to: RDFGraph.Service, as: :query_graph
  @doc "Delegates to RDFGraph.Service.query_graph!/1"
  defdelegate query_graph!(arg), to: RDFGraph.Service, as: :query_graph!

  @doc "Delegates to RDFGraph.Service.query_graph/2"
  defdelegate query_graph(arg, params), to: RDFGraph.Service, as: :query_graph
  @doc "Delegates to RDFGraph.Service.query_graph!/2"
  defdelegate query_graph!(arg, params), to: RDFGraph.Service, as: :query_graph!

  @doc "Delegates to RDFGraph.Service.rdf_store/0"
  defdelegate rdf_store(), to: RDFGraph.Service, as: :rdf_store
  @doc "Delegates to RDFGraph.Service.rdf_store/1"
  defdelegate rdf_store(arg), to: RDFGraph.Service, as: :rdf_store
  @doc "Delegates to RDFGraph.Service.list_rdf_stores/0"
  defdelegate list_rdf_stores(), to: RDFGraph.Service, as: :list_rdf_stores
  @doc "Delegates to RDFGraph.Service.rdf_store_admin/0"
  defdelegate rdf_store_admin(), to: RDFGraph.Service, as: :rdf_store_admin
  @doc "Delegates to RDFGraph.Service.rdf_store_query/0"
  defdelegate rdf_store_query(), to: RDFGraph.Service, as: :rdf_store_query

end
