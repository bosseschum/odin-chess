# frozen_string_literal: true

require_relative '../modules/movement'

# Class representing a Rook in a commandline chess game.
class Rook < Character
  include Movement
  attr_reader :starting_position
  attr_accessor :castling_rights

  def initialize(color, position)
    super
    @starting_position = position.dup
    @castling_rights = false
  end

  def moves
    slide
  end
end
