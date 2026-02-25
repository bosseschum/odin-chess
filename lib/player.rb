# frozen_string_literal: true

# Player class representing a player in a CLI chess game.
class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def input_move
    print "#{color} > "
    gets.chomp
  end
end
