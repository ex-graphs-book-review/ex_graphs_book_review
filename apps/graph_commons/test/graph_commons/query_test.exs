defmodule GraphCommons.QueryTest do
  use ExUnit.Case
  #  doctest GraphCommons.Query

  alias GraphCommons.Query

  def test_query() do
    data = "data"
    file = "test"
    type = :rdf
    %Query{data: data, file: file, type: type}
  end

  describe "Query struct" do
    test "one" do
      assert test_query()
    end
  end

  describe "new/3" do
    test "new/3" do
      data = "data"
      file = "test"
      type = :rdf
      query = %{Query.new(data, file, type) | path: nil, uri: nil}
      assert ^query = test_query()
    end
  end
end
