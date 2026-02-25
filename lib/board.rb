# frozen_string_literal: true

# Board class representing a chess board for a CLI chess game.
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_board
  end
end
