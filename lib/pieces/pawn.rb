# frozen_string_literal: true

# Class representing a pawn in a commandline chess game.
class Pawn < Character
  attr_reader :starting_position
  attr_accessor :en_passantable

  def initialize(color, position)
    super
    @starting_position = position.dup
    @en_passantable = false
  end

  def moves
    moves = []
    x, y = @position
    if @color == :black
      moves << [x, y + 1]
      moves << [x, y + 2] if @moved == false
    elsif @color == :white
      moves << [x, y - 1]
      moves << [x, y - 2] if @moved == false
    end
    moves
  end

  def captures
    captures = []
    x, y = @position
    if @color == :black
      captures << [x + 1, y + 1]
      captures << [x - 1, y + 1]
    elsif @color == :white
      captures << [x + 1, y - 1]
      captures << [x - 1, y - 1]
    end
    captures
  end
end
