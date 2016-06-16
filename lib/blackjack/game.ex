require IEx

defmodule Blackjack.Game do
  alias Blackjack.{Deck, Game, Player}

  defstruct deck: [], dealer_hand: [], player: %Player{}, phase: :bet

  def new(starting_bank \\ 100) do
    %Game{
      deck: Deck.new |> Deck.shuffle,
      player: %Player{bank: starting_bank},
    }
  end

  def deal(game = %Game{deck: deck}) do
    {[card1, card2, card3, card4], deck} = Deck.draw(deck, 4)
    player_hand = [card1, card3]
    dealer_hand = [card2, %{card4 | facing: :down}]
    player = %{game.player | hand: player_hand}
    %{game | phase: :resolve, deck: deck, dealer_hand: dealer_hand, player: player}
  end

  def bet(game = %Game{player: player}, amount) do
    %{game | player: %{player | bet: amount, bank: player.bank - amount}}
  end

  def player_hit(game = %Game{deck: deck, player: %Player{hand: hand}}) do
    {card, deck} = Deck.draw(deck)
    %{game | deck: deck, player: %{game.player | hand: hand ++ card}}
  end

  def dealer_hit(game = %Game{deck: deck, dealer_hand: hand}) do
    {cards, deck} = Deck.draw(deck)
    %{game | deck: deck, dealer_hand: hand ++ cards}
  end

  def phase(game, new_phase) do
    %{game | phase: new_phase}
  end

  # Dealer wins: take the player's bet and start a new round
  def dealer_win(game) do
    game
    |> new_round
  end

  # Player wins: payout the player and start a new round
  def player_win(game = %Game{player: %Player{bet: amount}}, odds \\ 2) do
    game
    |> add_to_bank(round(amount * odds))
    |> new_round
  end

  # Tie: return the player's bet to their bank and start a new round
  def push(game = %Game{player: %Player{bet: amount}}) do
    game
    |> add_to_bank(amount)
    |> new_round
  end

  defp add_to_bank(game = %Game{player: %Player{bank: bank}}, amount) do
    put_in(game.player.bank, bank + amount)
  end

  defp new_round(game) do
    %{game | phase: :bet, dealer_hand: [], player: %{game.player | bet: 0, hand: []}}
  end
end
