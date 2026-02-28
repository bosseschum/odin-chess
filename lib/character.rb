# frozen_string_literal: true

# Character class representing basic functionality for the pieces in a CLI chess game.
class Character
  attr_reader :color, :position
  attr_accessor :moved

  def initialize(color, position)
    @color = color
    @position = position
    @moved = false
  end

  def mark_moved
    @moved = true
  end

  def enemy?(piece)
    return false if piece.nil?

    @color != piece.color
  end
end
