defmodule NativeGraph.Builder do
  @moduledoc """
  Module for graph generators.
  """

  require Integer

  ## FUNCTIONS

  @doc """
  Generates a random graph with `limit` nodes.

  This is a very naive implementation of a randomly generated DAG.
  Low `limit` numbers are best.
  """
  @spec random_graph(integer) :: Graph.t()
  def random_graph(limit) do
    # start
    s = 1
    # end
    e = limit

    g = Graph.new()

    results =
      for(n <- s..e, m <- (n + 1)..e, do: _evaluate(n, m))
      |> Enum.reject(&is_nil/1)

    results
    |> Enum.reduce(
      g,
      fn result, g ->
        [rs, re] = result

        g
        |> Graph.add_edge(rs, re)
      end
    )
  end

  defp _evaluate(n, m) do
    case Integer.is_even(Kernel.trunc(System.os_time() / 1000)) do
      true -> [n, m]
      false -> nil
    end
  end
end
