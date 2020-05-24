defmodule GraphCommons.Service.GraphInfo do
  defstruct ~w[type file num_nodes num_edges labels]a

  @typedoc "Type for `%GraphCommons.Service.GraphInfo{}` struct."
  @type t :: %__MODULE__{
          type: :dgraph | :native | :property | :rdf | :tinker,
          file: String.t(),
          num_nodes: integer,
          num_edges: integer,
          labels: list
        }
end
