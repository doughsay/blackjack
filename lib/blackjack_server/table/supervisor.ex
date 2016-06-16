defmodule BlackjackServer.Table.Supervisor do
  use Supervisor

  @name BlackjackServer.Table.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_table do
    Supervisor.start_child(@name, [])
  end

  def init(:ok) do
    children = [
      worker(BlackjackServer.Table, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
