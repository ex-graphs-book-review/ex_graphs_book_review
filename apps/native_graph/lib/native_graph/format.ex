defmodule NativeGraph.Format do
  @moduledoc """
  Module for formatting as graphic.
  """

  ## ATTRIBUTES

  @graph_images_dir GraphCommons.storage_dir() <> "/native/graphs/images/"
  @binary_dir "/usr/local/bin"

  ## TYPES

  @type layout :: :dot | :neato | :twopi | :circo | :fdp | :sfdp | :patchwork | :osage

  ## FUNCTIONS

  @doc """
  Writes a graph to a `.png` file in the native graph images library.

  The layout tool used is selected by the `layout` argument and is one of the following atoms:

  * `:dot` − filter for drawing directed graphs
  * `:neato` − filter for drawing undirected graphs
  * `:twopi` − filter for radial layouts of graphs
  * `:circo` − filter for circular layout of graphs
  * `:fdp` − filter for drawing undirected graphs
  * `:sfdp` − filter for drawing large undirected graphs
  * `:patchwork` − filter for squarified tree maps
  * `:osage` − filter for array-based layouts
  """
  @spec to_png(GraphCommons.Graph.t(), layout) :: {:ok, String.t()}
  def to_png(%GraphCommons.Graph{} = graph, layout \\ :dot) do
    layout_cmd = Path.join(@binary_dir, Atom.to_string(layout))

    dot_file = graph.path
    png_file = @graph_images_dir <> Path.basename(dot_file, ".dot") <> ".png"

    with {_, 0} <-
           System.cmd(layout_cmd, ["-T", "png", dot_file, "-o", png_file]) do
      {:ok, Path.basename(png_file)}
      # else
      #   _ -> {:error, "! Error"}
    end
  end

  @doc false
  def dot_deps_to_exs(dot_file) do
    {:ok, dot} = File.read(dot_file)

    dg =
      [~s/Graph.new()\n/] ++
        (dot
         |> String.split("\n", trim: true)
         |> Enum.filter(fn s -> String.contains?(s, " -> ") end)
         |> Enum.map(fn
           s ->
             [_, x, _, y, _, z, _] = String.split(s, <<34>>)
             ~s/|> Graph.add_edge(:#{x}, :#{y}, label: "#{z}")\n/
         end))

    exs_file = Path.join(Path.dirname(dot_file), Path.basename(dot_file, ".dot") <> ".exs")
    File.write(exs_file, dg)
    IO.puts(exs_file)
  end
end
