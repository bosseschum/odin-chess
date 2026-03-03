# frozen_string_literal: true

require_relative '../modules/movement'

# Class to represent a Queen in a commandline chess game.
class Queen < Character
  include Movement
  attr_reader :starting_position

  def initialize(color, position)
    super
    @starting_position = position.dup
  end

  def moves
    slide + slide_diagonally
  end

  def symbol
    if @color == :white
      '♕'
    else
      '♛'
    end
  end
end
