defmodule BlackjackServer.Supervisor do
  use Supervisor

  @name BlackjackServer.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    children = [
      worker(BlackjackServer.TableRegistry, [BlackjackServer.TableRegistry]),
      supervisor(BlackjackServer.Table.Supervisor, []),
    ]

    supervise(children, strategy: :rest_for_one)
  end
end
