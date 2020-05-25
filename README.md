# ExGraphsBook (Review)

`ExGraphsBook` is an Elixir umbrella project to accompany the [ExGraphsBook]().

## Graph Services

Before accessing a graph service you will need to start one. You can check which service is currently running with the `graph_info/0` function:

```
iex> graph_info
** (CompileError) iex:3: undefined function graph_info/0
```

This returns an `undefined` error because no graph module was started.

We'll need to set the graph module with the `graph_service/1` function. Also for the `NativeGraph` and `PropertyGraph` modules we will need to explicitly start an Elixir application to manage the graph service. (In the case of `RDFGraph` we will use HTTP to connect to remote or local services.)


### 1. NativeGraph

Steps to get started:

1. Use the `graph_service/1` function to set the `NativeGraph` module
2. Start the `NativeGraph` application

#### 1.1 Set the NativeGraph module

```
iex> graph_service NativeGraph
NativeGraph
iex> graph_info               
** (exit) exited in: GenServer.call(NativeGraph.Service, {:get, #Function<1.131560594/1 in NativeGraph.Service.graph_info/0>}, 5000)
    ** (EXIT) no process: the process is not alive or there's no process currently associated with the given name, possibly because its application isn't started
    (elixir 1.10.3) lib/gen_server.ex:1013: GenServer.call/3
    (native_graph 0.1.0) lib/native_graph/service.ex:70: NativeGraph.Service.graph_info/0
iex> NativeGraph.Aplication.start
** (UndefinedFunctionError) function NativeGraph.Aplication.start/0 is undefined (module NativeGraph.Aplication is not available)
    NativeGraph.Aplication.start()
```

#### 1.2 Start the NativeGraph application

```
iex> NativeGraph.Application.start
dets: file "priv/service/native/ex_graphs_book.dets" not properly closed, repairing ...
{:ok, #PID<0.362.0>}
iex> graph_info                   
%GraphCommons.Service.GraphInfo{
  file: "book.graph",
  labels: ["Author", "Book", "Publisher"],
  num_edges: 5,
  num_nodes: 5,
  type: :native
}
```

### 2. PropertyGraph

Steps to get started:

1. Install a local Neo4j instance
2. Start the Neo4j server
3. Use the `graph_service/1` function to set the `PropertyGraph` module
4. Start the `PropertyGraph` application

#### 2.1 Install a local Neo4j instance

In the book we have used a [Neo4j Community Server](https://neo4j.com/download-center/#community) edition - requires registration.

#### 2.2 Start the Neo4j server

TBD

#### 2.3 Set the PropertyGraph module

```
iex> graph_service PropertyGraph         
PropertyGraph
iex> graph_info                          
** (exit) exited in: GenServer.call(Bolt.Sips.Router, {:get_connection, :direct, :default}, 5000)
    ** (EXIT) no process: the process is not alive or there's no process currently associated with the given name, possibly because its application isn't started
    ...
```

#### 2.4 Start the PropertyGraph application

```
iex> PropertyGraph.Application.start
{:ok, #PID<0.458.0>}
iex> graph_info                     
%GraphCommons.Service.GraphInfo{
  file: "",
  labels: ["Author", "Book", "Publisher"],
  num_edges: 5,
  num_nodes: 5,
  type: :property
}
```

### 3. RDFGraph

Steps to get started:

1. Install a local RDF instance (optional)
2. Use the `rdf_store/1` function to set the RDF store - see `config/config.exs`
3. Use the `graph_service/1` function to set the `RDFGraph` module
4. (No Elixir application needs to be started as RDF stores are reachable via HTTP)


#### 3.1 Install a local RDF instance

In the book we have used a [GraphDB Free](https://www.ontotext.com/products/graphdb/graphdb-free/) edition - requires registration.

We then created a repo `ex_graphs_book` which can be accessed via an API call to `localhost` on the default port `7200`.

#### 3.2 Set the RDF store

```
iex> rdf_store        
nil
iex> rdf_store :local
:ok
iex> rdf_store        
:local
iex> rdf_store_query                                
"http://localhost:7200/repositories/ex-graphs-book"
```

Note - see `config/config.exs` for setting up the SPARQL endpoints.

#### 3.3 Set the RDFGraph module

```
iex> graph_service RDFGraph
RDFGraph
iex> graph_info            
{:ok, nil}
```

#### 3.4 Query the RDF graph service

```
iex> "select * where {?s ?p ?o}" |> sparql!                 
%SPARQL.Query.Result{
  results: [
    %{
      "o" => ~I<http://purl.org/ontology/bibo/Book>,
      "p" => ~I<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>,
      "s" => ~L"urn:isbn:978-1-68050-252-7"
    },
    ...
  ],
  variables: ["s", "p", "o"]
}
```
