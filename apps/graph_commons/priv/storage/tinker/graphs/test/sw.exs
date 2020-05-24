g = Graph.new
|> Graph.add_vertices(
[ "six", "pandas", "numpy", "python-dateutil", "pytz", "pyspark", "matplotlib",
"spacy", "py4j", "jupyter", "jpy-console", "nbconvert", "ipykernel",
"jpy-client", "jpy-core", ]
)
|> Graph.add_edge("pandas", "numpy", label: "DEPENDS_ON")
|> Graph.add_edge("pandas", "pytz", label: "DEPENDS_ON")
|> Graph.add_edge("pandas", "python-dateutil", label: "DEPENDS_ON")
|> Graph.add_edge("python-dateutil", "six", label: "DEPENDS_ON")
|> Graph.add_edge("pyspark", "py4j", label: "DEPENDS_ON")
|> Graph.add_edge("matplotlib", "numpy", label: "DEPENDS_ON")
|> Graph.add_edge("matplotlib", "python-dateutil", label: "DEPENDS_ON")
|> Graph.add_edge("matplotlib", "six", label: "DEPENDS_ON")
|> Graph.add_edge("matplotlib", "pytz", label: "DEPENDS_ON")
|> Graph.add_edge("spacy", "six", label: "DEPENDS_ON")
|> Graph.add_edge("spacy", "numpy", label: "DEPENDS_ON")
|> Graph.add_edge("jupyter", "nbconvert", label: "DEPENDS_ON")
|> Graph.add_edge("jupyter", "ipykernel", label: "DEPENDS_ON")
|> Graph.add_edge("jupyter", "jpy-console", label: "DEPENDS_ON")
|> Graph.add_edge("jpy-console", "jpy-client", label: "DEPENDS_ON")
|> Graph.add_edge("jpy-console", "ipykernel", label: "DEPENDS_ON")
|> Graph.add_edge("jpy-client", "jpy-core", label: "DEPENDS_ON")
|> Graph.add_edge("nbconvert", "jpy-core", label: "DEPENDS_ON")
