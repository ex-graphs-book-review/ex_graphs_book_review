import igraph as ig
from typing import List, Tuple

Edge = Tuple[int, int]

def ig_full_graph(n: int) -> List[Edge]:
    g = ig.Graph.Full(n)
    return g.get_edgelist()

def ig_tree_graph(n: int, children: int) -> List[Edge]:
    g = ig.Graph.Tree(n, children)
    return g.get_edgelist()

def ig_random_graph(n: int, distance: float) -> List[Edge]:
    g = ig.Graph.GRG(n, distance)
    return g.get_edgelist()

def hello(name):
    return "Hello "+ str(name)

def goodbye(name):
    return "Goodbye "+ str(name)
import networkx as nx
from typing import List, Tuple

Edge = Tuple[int, int]

def nx_complete_graph(n: int) -> List[Edge]:
    """Returns edge list for a complete graph"""
    G = nx.complete_graph(n)
    return list(G.edges)

def nx_star_graph(n: int) -> List[Edge]:
    """Returns edge list for a star graph"""
    G = nx.star_graph(n)
    return list(G.edges)

def nx_wheel_graph(n: int) -> List[Edge]:
    """Returns edge list for a wheel graph"""
    G = nx.wheel_graph(n)
    return list(G.edges)

def hello(name: str) -> None:
    return "Hello " + str(name)

def goodbye(name: str) -> None:
    return "Goodbye " + str(name)

# print(complete_graph(4))

generators = {
    "complete_graph" : nx.complete_graph,
    "star_graph" : nx.star_graph
    }

def my_graph(n, name):
    return generators[str(name)]
    # import networkx as nx
    # G = generators[str(name)](n)
    # return list(G.edges)

# print(my_graph(4, "star_graph"))
# print(my_graph(4, "complete_graph"))
