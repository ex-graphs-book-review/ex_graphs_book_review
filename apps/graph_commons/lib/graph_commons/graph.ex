defmodule GraphCommons.Graph do
  @moduledoc ~S"""
  Module providing a struct for graphs.

  The `%GraphCommons.Graph{}` struct is used to bundle related data
  access fields for graph serializations together.

  One of the fields `:type` tracks `graph_type`:

  * `:native` – native graph
  * `:property` – property graph
  * `:rdf` – RDF graph
  * `:tinker` – TinkerPop graph

  The other fields are straightforward data access fields:

  * `:data` – `graph_data`
  * `:file` – name of `graph_file` (within the `graphs_dir`)
  * `:path` – absolute path of `graph_file`
  * `:uri` – absolute URI of `graph_file`

  """

  ## ATTRIBUTES

  @storage_dir GraphCommons.storage_dir()

  ## STRUCT

  @derive {Inspect, except: [:path, :uri]}
  @enforce_keys ~w[data file type]a
  defstruct ~w[data file path type uri]a

  ## TYPES

  @typedoc "Type for graph data string in graph storage."
  @type graph_data :: String.t()
  @typedoc "Type for file name of graph storage."
  @type graph_file :: String.t()
  @typedoc "Type for file path of graph storage."
  @type graph_path :: String.t()
  @typedoc "Type for type of graph in graph storage."
  @type graph_type :: GraphCommons.graph_type()
  @typedoc "Type for (file:) URI of graph storage."
  @type graph_uri :: String.t()

  @typedoc "Type for `%GraphCommons.Graph{}` struct."
  @type t :: %__MODULE__{
          # user
          data: graph_data,
          file: graph_file,
          type: graph_type,
          # system
          path: graph_path,
          uri: graph_uri
        }

  @type file_test :: GraphCommons.file_test()

  @doc ~S"""
  Guard to test for valid `file_type`.
  """
  defguard is_file_type(file_type)
           when file_type == :dir? or
                  file_type == :exists? or
                  file_type == :regular?

  @doc ~S"""
  Guard to test for valid `graph_type`.
  """
  defguard is_graph_type(graph_type)
           when graph_type == :dgraph or graph_type == :native or
                  graph_type == :property or graph_type == :rdf or
                  graph_type == :tinker

  ## CONSTRUCTOR

  @doc ~S"""
  Creates a `%GraphCommons.Graph{}` struct.

  ## Examples

      iex> "CREATE (a)-[:EX]->(b)" |>
      ...> GraphCommons.Graph.new("test.cypher", :property)
      #GraphCommons.Graph<type: property, file: "test.cypher", data: "CREATE (a)-[:EX]...">

      iex> "CREATE (TheMatrix:Movie {title:'The Matrix', released:1999})\n" |>
      ...> GraphCommons.Graph.new("test.cypher", :property)
      #GraphCommons.Graph<type: property, file: "test.cypher", data: "CREATE (TheMatri...">

  """
  @spec new(graph_data, graph_file, graph_type) :: t
  def new(graph_data, graph_file, graph_type)
      when is_graph_type(graph_type) do
    graph_path = "#{@storage_dir}/#{graph_type}/graphs/#{graph_file}"

    %__MODULE__{
      # user
      data: graph_data,
      file: graph_file,
      type: graph_type,
      # system
      path: graph_path,
      uri: "file://" <> graph_path
    }
  end

  ## FUNCTIONS

  # @doc ~S"""
  # Returns the `graphs` directory for the `graph_type`.
  # """
  # @spec graphs_dir(graph_type) :: String.t()
  # def graphs_dir(graph_type), do: "#{@storage_dir}/#{graph_type}/graphs/"

  @doc ~S"""
  Returns a (sorted) listing of the `graphs` directory, optionally filtered by `file_test`.
  """
  @spec list_graphs(graph_type, file_test) :: [String.t()]
  def list_graphs(graph_type, file_test \\ :exists?) do
    list_graphs_dir("", graph_type, file_test)
  end

  @doc ~S"""
  Returns a (sorted) listing of a named file in the `graphs` directory, optionally filtered by `file_test`.
  """
  @spec list_graphs_dir(graph_file, graph_type, file_test) :: [String.t()]
  def list_graphs_dir(graph_file, graph_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{graph_type}/graphs/"

    (path <> graph_file)
    |> File.ls!()
    |> _filter(path, file_test)
    |> Enum.sort()
    |> Enum.map(fn f ->
      File.dir?(path <> f)
      |> case do
        true -> "#{String.upcase(f)}"
        false -> f
      end
    end)
  end

  defp _filter(files, path, file_test) do
    files
    |> Enum.filter(fn f ->
      case file_test do
        :dir? -> File.dir?(path <> f)
        :regular? -> File.regular?(path <> f)
        :exists? -> true
      end
    end)
  end

  @doc ~S"""
  Returns a new graph with `graph_data` after reading storage for `graph_file` and `graph_type`.
  """
  @spec read_graph(graph_file, graph_type) :: t
  def read_graph(graph_file, graph_type)
      when graph_file != "" and is_graph_type(graph_type) do
    graphs_dir = "#{@storage_dir}/#{graph_type}/graphs/"
    graph_data = File.read!(graphs_dir <> graph_file)

    new(graph_data, graph_file, graph_type)
  end

  @doc ~S"""
  Returns a new graph with `graph_data` after writing storage for `graph_data`, `graph_file` and `graph_type`.
  """
  @spec write_graph(graph_data, graph_file, graph_type) :: t
  def write_graph(graph_data, graph_file, graph_type)
      when graph_data != "" and
             graph_file != "" and is_graph_type(graph_type) do
    graphs_dir = "#{@storage_dir}/#{graph_type}/graphs/"
    File.write!(graphs_dir <> graph_file, graph_data)

    new(graph_data, graph_file, graph_type)
  end

  ## MACROS

  defmacro __using__(opts) do
    graph_type = Keyword.get(opts, :graph_type)
    graph_module = Keyword.get(opts, :graph_module)

    quote do
      ## TYPES

      @type graph_file_test :: GraphCommons.file_test()

      @type graph_data :: GraphCommons.Graph.graph_data()
      @type graph_file :: GraphCommons.Graph.graph_file()
      @type graph_path :: GraphCommons.Graph.graph_path()
      @type graph_type :: GraphCommons.Graph.graph_type()
      @type graph_uri :: GraphCommons.Graph.graph_uri()

      @type graph_t :: GraphCommons.Graph.t()

      ## FUNCTIONS

      @doc false
      @spec graph_service() :: module
      def graph_service(), do: unquote(graph_module)

      @doc false
      @spec gs() :: GraphCommons.Service.GraphInfo.t()
      def gs() do
        graph_service()
        graph_info()
      end

      #  def gs(), do: graph_service(); graph_info()

      @doc """
      Lists graphs in the graphs library.
      """
      @spec list_graphs(graph_file_test) :: [String.t()]
      def list_graphs(graph_file_test \\ :exists?),
        do: GraphCommons.Graph.list_graphs(unquote(graph_type), graph_file_test)

      @doc """
      Lists graphs in a directory of the graphs library.
      """
      @spec list_graphs_dir(String.t(), graph_file_test) :: [String.t()]
      def list_graphs_dir(dir, graph_file_test \\ :exists?),
        do: GraphCommons.Graph.list_graphs_dir(dir, unquote(graph_type), graph_file_test)

      @doc ~S"""
      Creates a new graph.
      """
      @spec new_graph(graph_data) :: graph_t
      def new_graph(graph_data), do: new_graph(graph_data, "")

      @spec new_graph(graph_data, graph_file) :: graph_t
      def new_graph(graph_data, graph_file),
        do: GraphCommons.Graph.new(graph_data, graph_file, unquote(graph_type))

      @doc ~S"""
      Reads a graph from the graphs library.
      """
      @spec read_graph(graph_file) :: graph_t
      def read_graph(graph_file),
        do: GraphCommons.Graph.read_graph(graph_file, unquote(graph_type))

      @doc ~S"""
      Writes a graph to the graphs library.
      """
      @spec write_graph(graph_data, graph_file) :: graph_t
      def write_graph(graph_data, graph_file),
        do: GraphCommons.Graph.write_graph(graph_data, graph_file, unquote(graph_type))
    end
  end

  ## IMPLEMENTATIONS

  defimpl Inspect, for: __MODULE__ do
    @slice 16
    @quote <<34>>

    def inspect(%GraphCommons.Graph{} = graph, _opts) do
      type = graph.type
      file = @quote <> graph.file <> @quote

      str =
        graph.data
        |> String.replace("\n", "\\n")
        |> String.replace(@quote, "\\" <> @quote)
        |> String.slice(0, @slice)

      data =
        case String.length(str) < @slice do
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Graph<type: #{type}, file: #{file}, data: #{data}>"
    end
  end
end
