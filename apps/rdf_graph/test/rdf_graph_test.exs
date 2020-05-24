defmodule RDFGraphTest do
  use ExUnit.Case
  # doctest RDFGraph, only: [graph_file: 0, query_file: 0]
  doctest RDFGraph

  describe "read_graph/1" do
    test "has type: :rdf" do
      filename = "default.ttl"
      assert RDFGraph.read_graph(filename).type == :rdf
    end

    test "has file: filename" do
      filename = "default.ttl"
      assert RDFGraph.read_graph(filename).file == filename
    end
  end

  describe "read_query/1" do
    test "has type: :rdf" do
      filename = "default.rq"
      assert RDFGraph.read_query(filename).type == :rdf
    end

    test "has file: filename" do
      filename = "default.rq"
      assert RDFGraph.read_query(filename).file == filename
    end
  end
end
