defmodule PropertyGraph do
  @moduledoc """
  Module for reading and writing a library of property graphs and Cypher queries.

  The `read_graph/1` and `write_graph/2` functions allow for reading and writing
  RDF graphs to the project data repository. (Default file names are provided
  with the `read_graph/0` and `write_graph/1` forms.) The `list_graphs/0`
  function lists graph file names.

  The `read_query/1` and `write_query/2` functions allow for reading and writing
  SPARQL queries to the project data repository. (Default file names are
  provided with the `read_query/0` and `write_query/1` forms.) The
  `list_queries/0` function lists query file names.

  ## Examples

      iex> PropertyGraph.read_graph("default.cypher")
      #GraphCommons.Graph<type: property, file: "default.cypher", data: "CREATE (a)-[:EX]...">

      iex> "..." |> PropertyGraph.write_graph("my.test")
      #GraphCommons.Graph<type: property, file: "my.test", data: "...">
  """

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :property, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :property, query_module: __MODULE__

  ## GRAPH SERVICE

  @doc "Delegates to PropertyGraph.Service.graph_create/1"
  defdelegate graph_create(arg), to: PropertyGraph.Service, as: :graph_create
  @doc "Delegates to PropertyGraph.Service.graph_delete/0"
  defdelegate graph_delete(), to: PropertyGraph.Service, as: :graph_delete
  @doc "Delegates to PropertyGraph.Service.graph_info/0"
  defdelegate graph_info(), to: PropertyGraph.Service, as: :graph_info
  @doc "Delegates to PropertyGraph.Service.graph_read/0"
  defdelegate graph_read(), to: PropertyGraph.Service, as: :graph_read
  @doc "Delegates to PropertyGraph.Service.graph_update/1"
  defdelegate graph_update(arg), to: PropertyGraph.Service, as: :graph_update

  @doc "Delegates to PropertyGraph.Service.query_graph/1"
  defdelegate query_graph(arg), to: PropertyGraph.Service, as: :query_graph
  @doc "Delegates to PropertyGraph.Service.query_graph!/1"
  defdelegate query_graph!(arg), to: PropertyGraph.Service, as: :query_graph!

  @doc "Delegates to PropertyGraph.Service.query_graph/2"
  defdelegate query_graph(arg, params), to: PropertyGraph.Service, as: :query_graph
  @doc "Delegates to PropertyGraph.Service.query_graph!/2"
  defdelegate query_graph!(arg, params), to: PropertyGraph.Service, as: :query_graph!

  ## ATTRIBUTES

  # @books_graph_file "books.cypher"
  # @movies_graph_file "movies.cypher"

  ## FUNCTIONS

  # @doc ~S"""
  # Reads a `Books` graph from the graphs library.
  #
  # ## Examples
  #
  #     iex> PropertyGraph.books().data
  #     "CREATE\n(book:Book {\n    iri: \"urn:isbn:978-1-68050-252-7\",..."
  #
  # """
  # def books(), do: read_graph(@books_graph_file)
  #
  # @doc """
  # Reads a `Movies` graph from the graphs library.
  #
  # ## Examples
  #
  #     iex> PropertyGraph.movies().data
  #     "CREATE (TheMatrix:Movie {title:'The Matrix', released:1999,..."
  #
  # """
  # def movies(), do: read_graph(@movies_graph_file)
end
