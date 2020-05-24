defmodule GraphCommons.Utils do
  @moduledoc """
  Module providing helper functions.
  """

  # And see also https://www.openmymind.net/Elixir-Which-Modules-Use-My-Module/

  ## ATTRIBUTES

  @graph_modules [DGraph, NativeGraph, PropertyGraph, RDFGraph, TinkerGraph]

  defguard is_module(graph_module)
           when graph_module == DGraph or graph_module == NativeGraph or
                  graph_module == PropertyGraph or graph_module == RDFGraph or
                  graph_module == TinkerGraph

  @doc """
  Macro to set graph service with `graph_module`.
  """
  @spec graph_service(module) :: module
  # when is_module(graph_module)
  defmacro graph_service(graph_module) do
    quote do
      # unimport any existing graph modules
      # import DGraph, only: []
      import NativeGraph, only: []
      import PropertyGraph, only: []
      import RDFGraph, only: []
      # import TinkerGraph, only: []
      # import graph module argument
      import unquote(graph_module)
    end
  end

  @spec graph_service(module) :: GraphCommons.Service.GraphInfo.t()
  defmacro gs(graph_module) do
    quote do
      graph_service(unquote(graph_module))
      graph_info()
    end
  end

  defmacro repeat(times, block) do
    quote do
      for _ <- 1..unquote(times), do: unquote(block)
    end
  end

  ## QUERY HELPERS

  # @doc """
  # Helper function which creates a `%GraphCommons.Query{}` from a `query_string` arg and queries the graph store.
  # """
  @spec to_query_graph!(module, String.t()) :: any
  defp to_query_graph!(graph_module, query_string)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!()
  end

  defp to_query_graph!(graph_module, query_string, query_params)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!(query_params)
  end

  @spec to_query_graph(module, String.t()) :: any
  defp to_query_graph(graph_module, query_string)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph()
  end

  @spec dgraph!(String.t()) :: any
  def dgraph!(query_string), do: to_query_graph(DGraph, query_string)

  @doc """
  Queries a `PropertyGraph` graph store with a tuple arg containing a `query_string` string arg and a `query_params` map arg.
  """
  @spec cypher!({String.t(), map()}) :: any
  def cypher!({query_string, query_params}),
    do: to_query_graph!(PropertyGraph, query_string, query_params)

  @doc """
  Queries a `PropertyGraph` graph store with a `query_string` string arg.
  """
  @spec cypher!(String.t()) :: any
  def cypher!(query_string), do: to_query_graph!(PropertyGraph, query_string)


  @spec cypher(String.t()) :: any
  def cypher(query_string), do: to_query_graph(PropertyGraph, query_string)

  @doc """
  Queries a `PropertyGraph` graph store with a `query_string` string arg and a `query_params` map arg.
  """
  @spec cypher!(String.t(), map()) :: any
  def cypher!(query_string, query_params),
    do: to_query_graph!(PropertyGraph, query_string, query_params)

  @doc """
  Queries a `TinkerGraph` graph store with a `query_string` arg.
  """
  @spec gremlin!(String.t()) :: any
  def gremlin!(query_string), do: to_query_graph!(TinkerGraph, query_string)

  @doc """
  Queries a `NativeGraph` graph store with a `query_string` arg.
  """
  @spec libgraph!(String.t()) :: any
  def libgraph!(query_string), do: to_query_graph!(NativeGraph, query_string)

  @doc """
  Queries a `RDFGraph` graph store with a `query_string` arg.
  """
  @spec sparql!(String.t()) :: any
  def sparql!(query_string), do: to_query_graph!(RDFGraph, query_string)

  @doc """
  Queries a `RDFGraph` graph store with a `query_string` arg.
  """
  @spec sparql(String.t()) :: any
  def sparql(query_string), do: to_query_graph(RDFGraph, query_string)
  ## FUNCTIONS

  @doc """
  Queries a `RDFGraph` graph store with a `query_string` string arg and a `query_params` map arg.
  """
  @spec sparql!(String.t(), map()) :: any
  def sparql!(query_string, query_params),
    do: to_query_graph!(RDFGraph, query_string, query_params)

  @doc """
  Generates keyword list of app, module pairs from graph modules used in this umbrella app.
  """
  @spec graph_modules() :: keyword
  def graph_modules do
    Enum.reduce(list_graph_modules(), [], fn m, acc ->
      acc ++ [{Application.get_application(m), m}]
    end)
  end

  @doc """
  Prints out toplevel graph modules used in this umbrella app.
  """
  @spec list_graph_modules() :: nonempty_list(module)
  def list_graph_modules, do: @graph_modules

  # @doc """
  # Prints out all imported modules.
  # """
  # @spec list_imported_modules() :: nonempty_list(module())
  # def list_imported_modules do
  #   __ENV__.functions |> Enum.map(fn {m,_} -> m end)
  # end
  #
  # def test_module(m) do
  #   List.keymember? __ENV__.functions, m , 0
  # end

  @doc """
  Prints out apps used in this umbrella app.

  ## Examples

      iex> list_apps
      [:graph_browser, :graph_commons, :graph_connect, :graph_transform,
       :native_graph, :property_graph, :rdf_graph]
      :ok
  """
  @spec list_apps() :: :ok
  def list_apps do
    list =
      Mix.Project.config()[:apps]
      |> case do
        nil -> [Mix.Project.config()[:app]]
        _ -> Mix.Project.config()[:apps]
      end

    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end

  @doc """
  Prints out modules used in app.

  ## Examples

      iex> list_mods(:graph_commons)
      [help: 0, list_apps: 0, list_functions: 1, list_modules: 1]
      :ok
  """
  @spec list_modules(atom) :: :ok
  def list_modules(app) do
    {:ok, list} = :application.get_key(app, :modules)
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end

  @doc """
  Prints out functions used in module.

  ## Examples

      iex> list_functions(GraphCommons)
      [GraphCommons, GraphCommons.Graph, GraphCommons.Query, GraphCommons.Utils,
       Inspect.GraphCommons.Graph, Inspect.GraphCommons.Query]
      :ok
  """
  @spec list_functions(module) :: :ok
  def list_functions(module) do
    # function_exported?(module, :__info__, 1)
    list = module.__info__(:functions)
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end

  @doc """
  Prints out macros used in module.

  ## Examples

      iex> list_macros(GraphCommons.Utils)
      [graph_service: 1, gs: 1, is_module: 1]
      :ok
  """
  @spec list_macros(module) :: :ok
  def list_macros(module) do
    # function_exported?(module, :__info__, 1)
    list = module.__info__(:macros)
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end

  @doc """
  Prints out ...

  ## Examples

      iex> help
      [:graph_commons]
      :ok
  """
  @spec help() :: :ok
  def help(), do: list_apps()

  @doc """
  Prints out ...
  """
  @spec help(atom()) :: :ok
  def help(arg) when is_atom(arg) do
    arg
    |> :application.get_key(:modules)
    |> case do
      {:ok, _} ->
        list_modules(arg)

      :undefined ->
        Code.ensure_loaded(arg)

        arg
        |> function_exported?(:__info__, 1)
        |> case do
          true -> list_functions(arg)
          false -> raise "! Unknown arg: #{arg}"
        end
    end
  end

  @doc """
  Returns result of evaluating a script bundled with the `:graph_commons` app.
  """
  @spec eval_script(String.t()) :: any
  def eval_script(script) do
    with {result, _} <- Code.eval_file(Path.join(GraphCommons.scripts_dir(), script)) do
      result
      # else
      #   _ -> raise "! Error running #{script}"
    end
  end

  @doc """
  Returns result of evaluating a string.
  """
  @spec eval(String.t()) :: any
  def eval(string) do
    with {result, _} <- Code.eval_string(string) do
      result
      # else
      #   err -> IO.puts "! Error running #{err}"
    end
  end


# https://stackoverflow.com/questions/38058053/how-do-i-detect-database-connection-issues-from-elixir-ecto
  # iex(16)> {:ok, socket} = :gen_tcp.connect('127.0.0.1', 7687, [])
  # {:ok,  #Port <0.6249>}
  # iex(17)> socket
  #  #Port <0.6249>
  # iex(18)> :gen_tcp.close socket
  # :ok

  def open_socket(address, port) do
    # :gen_tcp.connect(address, port, [])
    case :gen_tcp.connect(address, port, []) do
      {:ok, _} -> true
        # code for handling ok scenario
      {:error, error} -> false
        # code for handling error scenario
    end
  end

  # @spec close_socket(String.t()) :: :ok
  def close_socket(socket) do
    :gen_tcp.close(socket)
  end

end
