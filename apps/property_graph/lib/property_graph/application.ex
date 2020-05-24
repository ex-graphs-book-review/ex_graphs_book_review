defmodule PropertyGraph.Application do
  @moduledoc false

  use Application

  def start, do: start(nil, nil)

  def start(_type, _args) do
    children = [
      {Bolt.Sips, Application.get_env(:bolt_sips, Bolt)}
    ]

    opts = [strategy: :one_for_one, name: PropertyGraph.Service]

    Supervisor.start_link(children, opts)
    # GraphCommons.Utils.open_socket('127.0.0.1', 7687)
    # :gen_tcp.connect('127.0.0.1', 7687, [])
    # |>
    # case  do
    #   {:ok, _} -> Supervisor.start_link(children, opts)
    #   {:error, :econnrefused} -> {:ok, self()}
    # end
  end

  def stop(_args) do
    IO.puts "! Called PropertyGraph.Application.stop/1"
  end

end
