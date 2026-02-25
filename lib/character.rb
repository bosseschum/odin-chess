# frozen_string_literal: true

# Character class representing basic functionality for the pieces in a CLI chess game.
class Character
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end
end
