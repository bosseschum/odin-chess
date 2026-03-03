# frozen_string_literal: true

class Knight < Character
  attr_reader :starting_position

  def initialize(color, position)
    super
    @starting_position = position.dup
  end

  def moves
    x, y = @position
    offset = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]

    offset.map { |dx, dy| [x + dx, y + dy] }
  end

  def symbol
    if @color == :white
      '♘'
    else
      '♞'
    end
  end
end
