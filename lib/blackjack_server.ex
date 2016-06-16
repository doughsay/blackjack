defmodule BlackjackServer do
  use Application

  def start(_type, _args) do
    BlackjackServer.Supervisor.start_link
  end
end
