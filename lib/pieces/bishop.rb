# frozen_string_literal: true

require_relative '../modules/movement'

# Class to represent a Bishop piece in a commandline chess game.
class Bishop < Character
  include Movement
  attr_reader :starting_position

  def initialize(color, position)
    super
    @starting_position = position.dup
  end

  def moves
    slide_diagonally
  end

  def symbol
    if @color == :white
      '♗'
    else
      '♝'
    end
  end
end
