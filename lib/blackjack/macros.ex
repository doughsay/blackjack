defmodule Blackjack.Macros do
  defmacro face(value) do
    quote do
      unquote(value) in [:jack, :queen, :king]
    end
  end
end
