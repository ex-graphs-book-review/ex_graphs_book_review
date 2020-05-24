defmodule GraphCommons do
  @moduledoc """
  Core module for the [ExGraphsBook](https://github.com/tonyhammond/ex_graphs_book) umbrella project.

  This module serves as the entry point for the documentation as well as
  providing the basic structs `%Graph{}` and `%Query{}` in `GraphCommons.Graph`
  and `GraphCommons.Query`, respectively.
  """

  ## ATTRIBUTES

  @priv_dir "#{:code.priv_dir(:graph_commons)}"

  ## TYPES

  @typedoc "Types for graph storage."
  #  @type base_type :: :native | :property | :rdf | :tinker
  @type base_type :: :dgraph | :native | :property | :rdf | :tinker
  @type graph_type :: base_type()
  @type query_type :: base_type()

  @typedoc "Type for testing file types."
  @type file_test :: :dir? | :regular? | :exists?

  ## FUNCTIONS

  @doc """
  Returns the common exports area under the `:graph_commons` app.
  """
  @spec exports_dir() :: String.t()
  def exports_dir(), do: @priv_dir <> "/transfer/exports"

  @doc """
  Returns the common imports area under the `:graph_commons` app.
  """
  @spec imports_dir() :: String.t()
  def imports_dir(), do: @priv_dir <> "/transfer/imports"

  @doc """
  Returns the common scripts area under the `:graph_commons` app.
  """
  @spec scripts_dir() :: String.t()
  def scripts_dir(), do: @priv_dir <> "/extras/scripts"

  @doc """
  Returns the common storage area under the `:graph_commons` app.
  """
  @spec storage_dir() :: String.t()
  def storage_dir(), do: @priv_dir <> "/storage"

  @doc """
  Hello world for the `ExGraphsBook` umbrella app.

  ## Examples

      iex> GraphCommons.hello()
      This is ExGraphsBook - an Elixir umbrella app:

      [:graph_browser, :graph_commons, :graph_connect, :graph_share, :graph_transform,
       :native_graph, :property_graph, :rdf_graph, :tinker_graph]
      :ok
  """
  @spec hello() :: :ok
  def hello do
    IO.puts("This is ExGraphsBook - an Elixir umbrella app:\n")
    GraphCommons.Utils.list_apps()
  end
end
