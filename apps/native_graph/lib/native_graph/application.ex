defmodule NativeGraph.Application do
  @moduledoc false

  use Application

  def start, do: start(nil, nil)

  def start(_type, _args) do
    children = [
      {NativeGraph.Service, []}
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
