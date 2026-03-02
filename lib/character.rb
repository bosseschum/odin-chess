# frozen_string_literal: true

# Character class representing basic functionality for the pieces in a CLI chess game.
class Character
  attr_reader :color
  attr_accessor :moved, :position

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

  def to_s
    "#{color.capitalize} #{self.class.name} at #{position}"
  end
end
