import igraph as ig
from typing import List, Tuple

Edge = Tuple[int, int]

# def ig_test_graph(gml_file: bytes) -> List[Edge]:
def ig_test_graph(gml_file):
    g = ig.Graph.Read_GML(gml_file.to_string())
    return (g.vs()["label"], g.get_edgelist())

def ig_full_graph(n: int) -> List[Edge]:
    g = ig.Graph.Full(n)
    return g.get_edgelist()

def ig_star_graph(n: int) -> List[Edge]:
    g = ig.Graph.Star(n)
    return g.get_edgelist()

def ig_random_graph(n: int, distance: float) -> List[Edge]:
    g = ig.Graph.GRG(n, distance)
    return g.get_edgelist()

def ig_tree_graph(n: int, children: int) -> List[Edge]:
    g = ig.Graph.Tree(n, children)
    return g.get_edgelist()


def hello(name):
    return "Hello "+ str(name)

def goodbye(name):
    return "Goodbye "+ str(name)
