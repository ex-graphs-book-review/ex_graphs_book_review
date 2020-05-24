defmodule GraphCommons.Query do
  @moduledoc ~S"""
  Module providing a struct for queries.

  The `%GraphCommons.Query{}` struct is used to bundle related data
  access fields for query serializations together.

  One of the fields `:type` tracks `query_type`:

  * `:native` – native query
  * `:property` – property query
  * `:rdf` – RDF query
  * `:tinker` – TinkerPop query

  The other fields are straightforward data access fields:

  * `:data` – `query_data`
  * `:file` – name of `query_file` (within the `queries_dir`)
  * `:path` – absolute path of `query_file`
  * `:uri` – absolute URI of `query_file`

  """

  ## ATTRIBUTES

  @storage_dir GraphCommons.storage_dir()

  ## STRUCT

  @derive {Inspect, except: [:path, :uri]}
  @enforce_keys ~w[data file type]a
  defstruct ~w[data file path type uri]a

  ## TYPES

  @typedoc "Type for query data string in query storage."
  @type query_data :: String.t()
  @typedoc "Type for file name of query storage."
  @type query_file :: String.t()
  @typedoc "Type for file path of query storage."
  @type query_path :: String.t()
  @typedoc "Type for type of query in query storage."
  @type query_type :: GraphCommons.query_type()
  @typedoc "Type for (file:) URI of query storage."
  @type query_uri :: String.t()

  @typedoc "Type for `%GraphCommons.Query{}` struct."
  @type t :: %__MODULE__{
          data: query_data,
          file: query_file,
          path: query_path,
          type: query_type,
          uri: query_uri
        }

  @typedoc "Type for testing file types."
  @type file_test :: GraphCommons.file_test()

  defguard is_type(query_type)
           when query_type == :dgraph or query_type == :native or
                  query_type == :property or query_type == :rdf or
                  query_type == :tinker

  ## CONSTRUCTOR

  @doc ~S"""
  Creates a `%GraphCommons.Query{}` struct.

  ## Examples

      iex> query = RDFGraph.read_query
      #GraphCommons.Query<type: rdf, file: "default.rq", data: "construct\n{ ?s ?p ?o }\...">

      iex> query.data |> GraphCommons.Query.new("test.rq", :rdf)
      #GraphCommons.Query<type: rdf, file: "test.rq", data: "construct\n{ ?s ?p ?o }\...">

  """
  @spec new(query_data, query_file, query_type) :: t
  def new(query_data, query_file, query_type)
      when is_type(query_type) do
    query_path = "#{@storage_dir}/#{query_type}/queries/#{query_file}"

    %__MODULE__{
      # user
      data: query_data,
      file: query_file,
      type: query_type,
      # system
      path: query_path,
      uri: "file://" <> query_path
    }
  end

  ## FUNCTIONS

  # @doc ~S"""
  # Returns the `queries` directory for the `query_type`.
  # """
  # @spec queries_dir(query_type) :: String.t()
  # def queries_dir(query_type), do: "#{@storage_dir}/#{query_type}/queries/"

  @doc ~S"""
  Returns a listing of the `queries` directory, optionally filtered by `file_test`.
  """
  @spec list_queries(query_type, file_test) :: [String.t()]
  def list_queries(query_type, file_test \\ :exists?) do
    list_queries_dir("", query_type, file_test)
  end

  @doc ~S"""
  Returns a listing of a named file in the `queries` directory, optionally filtered by `file_test`.
  """
  @spec list_queries_dir(query_file, query_type, file_test) :: [String.t()]
  def list_queries_dir(query_file, query_type, file_test \\ :exists?) do
    path = "#{@storage_dir}/#{query_type}/queries/"
    #  path = queries_dir(query_type)

    (path <> query_file)
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
  Returns a new query with `query_data` after reading storage for `query_file` and `query_type`.
  """
  @spec read_query(query_file, query_type) :: t
  def read_query(query_file, query_type)
      when query_file != "" and is_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    query_data = File.read!(queries_dir <> query_file)

    new(query_data, query_file, query_type)
  end

  @doc ~S"""
  Returns a new query with `query_data` after writing storage for `query_data`, `query_file` and `query_type`.
  """
  @spec write_query(query_data, query_file, query_type) :: t
  def write_query(query_data, query_file, query_type)
      when query_data != "" and query_file != "" and is_type(query_type) do
    queries_dir = "#{@storage_dir}/#{query_type}/queries/"
    File.write!(queries_dir <> query_file, query_data)

    new(query_data, query_file, query_type)
  end

  ## MACROS

  defmacro __using__(opts) do
    query_type = Keyword.get(opts, :query_type)

    quote do
      ## TYPES

      @type query_file_test :: GraphCommons.file_test()

      @type query_data :: GraphCommons.Query.query_data()
      @type query_file :: GraphCommons.Query.query_file()
      @type query_path :: GraphCommons.Query.query_path()
      @type query_type :: GraphCommons.Query.query_type()
      @type query_uri :: GraphCommons.Query.query_uri()

      @type query_t :: GraphCommons.Query.t()

      ## FUNCTIONS

      # @doc false
      # # @spec queries_dir() :: String.t()
      # defp queries_dir, do: GraphCommons.Query.queries_dir(unquote(query_type))

      @doc """
      Lists graphs in the graphs library.
      """
      @spec list_queries(query_file_test) :: [String.t()]
      def list_queries(query_file_test \\ :exists?),
        do: GraphCommons.Query.list_queries(unquote(query_type), query_file_test)

      @doc """
      Lists graphs in a directory of the graphs library.
      """
      @spec list_queries_dir(String.t(), query_file_test) :: [String.t()]
      def list_queries_dir(dir, query_file_test \\ :exists?),
        do: GraphCommons.Query.list_queries_dir(dir, unquote(query_type), query_file_test)

      @doc ~S"""
      Creates a new query.
      """
      @spec new_query(query_data) :: query_t
      def new_query(query_data), do: new_query(query_data, "")

      @spec new_query(query_data, query_file) :: query_t
      def new_query(query_data, query_file),
        do: GraphCommons.Query.new(query_data, query_file, unquote(query_type))

      @doc ~S"""
      Reads a graph from the graphs library.
      """
      @spec read_query(query_file) :: query_t
      def read_query(query_file),
        do: GraphCommons.Query.read_query(query_file, unquote(query_type))

      @doc ~S"""
      Writes a graph to the graphs library.
      """
      @spec write_query(query_data, query_file) :: query_t
      def write_query(query_data, query_file),
        do: GraphCommons.Query.write_query(query_data, query_file, unquote(query_type))
    end
  end

  ## IMPLEMENTATIONS

  defimpl Inspect, for: __MODULE__ do
    @slice 16
    @quote <<34>>

    def inspect(%GraphCommons.Query{} = query, _opts) do
      type = query.type
      file = @quote <> query.file <> @quote

      str =
        query.data
        |> String.replace("\n", "\\n")
        |> String.replace(@quote, "\\" <> @quote)
        |> String.slice(0, @slice)

      data =
        case String.length(str) < @slice do
          true -> @quote <> str <> @quote
          false -> @quote <> str <> "..." <> @quote
        end

      "#GraphCommons.Query<type: #{type}, file: #{file}, data: #{data}>"
    end
  end
end
