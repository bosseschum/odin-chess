# frozen_string_literal: true

class King
  attr_reader :starting_position
  attr_accessor :in_check, :castling_rights

  def initialize(color, position)
    super
    @starting_position = position.dup
    @in_check = false
    @castling_rights = false
  end
end
