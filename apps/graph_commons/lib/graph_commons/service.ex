defmodule GraphCommons.Service do
  @moduledoc """
  Module defining graph service behaviour callbacks.

  This behaviour defines a CRUD interface to a graph service with the following callbacks:

  * `graph_create/1`
  * `graph_read/0`
  * `graph_update/1`
  * `graph_delete/0`

  Added to that basic set is an optional callback:

  * `graph_info/0`

  And lastly we also define a couple callbacks for querying the graph:

  * `query_graph/1`
  * `query_graph!/1`

  For interactive use the following function helpers are provided:

  * `GraphCommons.Utils.cypher!/1`
  * `GraphCommons.Utils.gremlin!/1`
  * `GraphCommons.Utils.libgraph!/1`
  * `GraphCommons.Utils.sparql!/1`

  These latter will typically be imported so that they can be invoked with no namespacing required, e.g `cypher/1`, `gremlin!/1`, `libgraph!/1`, `sparql!/1`.
  """
  @optional_callbacks graph_info: 0
  @optional_callbacks query_graph: 2
  @optional_callbacks query_graph!: 2

  ## GRAPH
  @doc "Creates graph in the service graph store."
  @callback graph_create(GraphCommons.Graph.t()) :: any()

  @doc "Deletes graph in the service graph store."
  @callback graph_delete() :: any()

  @doc "Reports on graph in the service graph store."
  @callback graph_info() :: any()

  @doc "Reads graph from the service graph store."
  # @callback graph_read() :: GraphCommons.Graph.t
  @callback graph_read() :: any()

  @doc "Writes graph to the service graph store."
  @callback graph_update(GraphCommons.Graph.t()) :: any()

  ## QUERY
  @doc "Queries graph in the service graph store."
  @callback query_graph(GraphCommons.Query.t()) :: any()

  @doc "Queries graph in the service graph store with direct result."
  @callback query_graph!(GraphCommons.Query.t()) :: any()

  @doc "Queries graph in the service graph store."
  @callback query_graph(GraphCommons.Query.t(), map()) :: any()

  @doc "Queries graph in the service graph store with direct result."
  @callback query_graph!(GraphCommons.Query.t(), map()) :: any()
end
