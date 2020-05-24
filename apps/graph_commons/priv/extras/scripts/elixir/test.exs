defmodule Test.ProcessGraph do

  alias NativeGraph.Examples.ProcessGraph

  def graph_up do
    ProcessGraph.graph_up(NativeGraph.read_graph("sw.graph").data |> GraphCommons.Utils.eval)
  end

  def add_state do
    IO.inspect ProcessGraph.get_state_by_id(7)
    ProcessGraph.put_state_by_id(7, {:one, "One"})
    ProcessGraph.put_state_by_id(7, {:two, "Two"})
    ProcessGraph.put_state_by_id(7, {:three, "Three"})
    ProcessGraph.put_state_by_id(7, {:four, "Four"})
    ProcessGraph.put_state_by_id(7, {:five, "Five"})
    IO.inspect ProcessGraph.get_state_by_id(7)
  end

end
