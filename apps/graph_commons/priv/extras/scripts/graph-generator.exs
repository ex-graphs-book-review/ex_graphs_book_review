GraphConnect.complete_graph(40)
|> GraphConnect.from_edgelist
|> Graph.to_dot
|> Tuple.to_list
|> List.last
|> NativeGraph.write_graph("complete-graph-40.dot")

