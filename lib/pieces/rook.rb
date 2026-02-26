# frozen_string_literal: true

class Rook < Character
  attr_reader :starting_position
  attr_accessor :castling_rights

  def initialize(color, position)
    super
    @starting_position = position.dup
    @castling_rights = false
  end
end
