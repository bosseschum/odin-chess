# frozen_string_literal: true

class King < Character
  attr_reader :starting_position
  attr_accessor :in_check, :castling_rights

  def initialize(color, position)
    super
    @starting_position = position.dup
  end

  def moves
    moves = []

    x, y = @position
    moves.push([x + 1, y], [x, y + 1], [x - 1, y], [x, y - 1],
               [x + 1, y + 1], [x + 1, y - 1], [x - 1, y + 1],
               [x - 1, y - 1])
  end

  def symbol
    if @color == :white
      '♔'
    else
      '♚'
    end
  end
end
