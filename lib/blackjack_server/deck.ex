defmodule BlackjackServer.Deck do
  alias Blackjack.Deck

  def start_link do
    Agent.start_link(&Deck.new/0)
  end

  def get(deck_server) do
    Agent.get(deck_server, &(&1))
  end

  def shuffle(deck_server) do
    Agent.update(deck_server, &Deck.shuffle/1)
  end

  def draw(deck_server), do: draw(deck_server, 1)
  def draw(deck_server, n) do
    Agent.get_and_update(deck_server, &Deck.draw(&1, n))
  end
end
