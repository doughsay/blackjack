defmodule Blackjack.Dealer do
  def move({17, :soft}), do: Application.get_env(:blackjack, :dealer_move_on_soft_17, :hit)
  def move({sum, _}) when sum < 17, do: :hit
  def move(_), do: :stand
end
