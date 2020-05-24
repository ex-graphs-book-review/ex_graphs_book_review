defmodule NativeGraph.Examples.ProcessGraph do
  @moduledoc false

  def graph_up() do
    g =
      GraphConnect.Client.nx_star_graph(12)
      |> NativeGraph.Utils.from_edgelist()

    graph_up(g)
  end

  def graph_up(%Graph{} = g) do
    h = Graph.new()
    m = Map.new()

    # vertices
    h =
      g
      |> Graph.vertices()
      |> Enum.reduce(h, fn v, h ->
        p = GraphShare.genserver_d()
        GraphShare.Client.put(p, :id, v)
        GraphShare.Server.register_name(p, "Node.#{v}")
        Graph.add_vertex(h, p)
      end)

    # map (vertex ID -> PID )
    m =
      h
      |> Graph.vertices()
      |> Enum.reduce(m, fn p, m ->
        v = GraphShare.Client.get(p, :id)
        Map.put(m, v, p)
      end)

    # edges
    h =
      g
      |> Graph.edges()
      |> Enum.reduce(h, fn e, h ->
        %Graph.Edge{label: label, v1: v1, v2: v2, weight: _} = e
        p = GraphShare.genserver_d()
        GraphShare.Client.put(p, :label, label)
        GraphShare.Client.put(p, :v1, Map.get(m, v1))
        GraphShare.Client.put(p, :v2, Map.get(m, v2))
        GraphShare.Server.register_name(p, "Edge.#{v1}->#{v2}")
        Graph.add_edge(h, Map.get(m, v1), Map.get(m, v2), label: label)
      end)

    h
  end

  def get_state(p) do
    GraphShare.Client.get(p)
  end

  def get_state_by_id(vertex_id) do
    p = GraphShare.Server.lookup_name(Integer.to_string(vertex_id))
    GraphShare.Client.get(p)
  end

  def poke(p) do
    put_state(p, {:pokes, 1})
  end



  def put_state(p, {name, value}) do
    GraphShare.Client.put(p, name, value)
  end

  def put_state_by_id(vertex_id, {name, value}) do
    p = GraphShare.Server.lookup_name(Integer.to_string(vertex_id))
    GraphShare.Client.put(p, name, value)
  end
end
