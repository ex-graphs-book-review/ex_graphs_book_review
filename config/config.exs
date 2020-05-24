# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
import Config

## PROPERTY_GRAPH

config :bolt_sips, Bolt, url: "bolt://neo4j:neo4jtest@localhost:7687", timeout: 30_000

## RDF_GRAPH

# HTTP client
config :tesla,
  adapter: Tesla.Adapter.Hackney

# RDF database access

config :rdf_graph,
  cur_graph_store: :local,
  graph_store: %{
    local: %{
      admin: "http://localhost:7200/repositories/ex-graphs-book/rdf-graphs/service?default",
      query: "http://localhost:7200/repositories/ex-graphs-book"
    },
    dbpedia: %{
      admin: nil,
      query: "http://dbpedia.org/sparql"
    },
    nobelprize: %{
      admin: nil,
      query: "http://data.nobelprize.org/sparql"
    },
    wikidata: %{
      admin: nil,
      query: "https://query.wikidata.org/bigdata/namespace/wdq/sparql"
    }
  }

# For loading per app config files
# for config <- "apps/*/config/config.exs" |> Path.expand() |> Path.wildcard() do
#   import_config config
# end
