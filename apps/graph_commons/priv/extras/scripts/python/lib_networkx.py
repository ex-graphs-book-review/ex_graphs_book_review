import networkx as nx
from typing import List, Tuple

Edge = Tuple[int, int]

def nx_windmill_graph(n: int, size: int) -> List[Edge]:
    """Returns edge list for a windmill graph"""
    G = nx.windmill_graph(n, size)
    return list(G.edges)

def nx_test_graph():
    G = nx.read_gml('lesmiserables.gml')
    return (list(G.nodes), list(G.edges))

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

def nx_florentine_families_graph() -> List[Edge]:
    """Returns edge list for the florentine families graph"""
    G = nx.florentine_families_graph()
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
