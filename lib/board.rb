# frozen_string_literal: true

# Board class representing a chess board for a CLI chess game.
class Board
  attr_reader :grid

  def initialize(empty: false)
    @grid = Array.new(8) { Array.new(8) }
    @empty = empty
    setup_board unless @empty == true
  end

  def setup_board
    # Pawns
    8.times do |col|
      place(Pawn.new(:white, [6, col]))
      place(Pawn.new(:black, [1, col]))
    end

    # Rooks
    place(Rook.new(:white, [7, 0]))
    place(Rook.new(:white, [7, 7]))
    place(Rook.new(:black, [0, 0]))
    place(Rook.new(:black, [0, 7]))

    # Knights
    place(Knight.new(:white, [7, 1]))
    place(Knight.new(:white, [7, 6]))
    place(Knight.new(:black, [0, 1]))
    place(Knight.new(:black, [0, 6]))

    # Bishops
    place(Bishop.new(:white, [7, 2]))
    place(Bishop.new(:white, [7, 5]))
    place(Bishop.new(:black, [0, 2]))
    place(Bishop.new(:black, [0, 5]))

    # Queens
    place(Queen.new(:white, [7, 3]))
    place(Queen.new(:black, [0, 3]))

    # Kings
    place(King.new(:white, [7, 4]))
    place(King.new(:black, [0, 4]))
  end

  def place(piece)
    row, col = piece.position
    grid[row][col] = piece
  end

  def at(position)
    row, col = position
    @grid[row][col]
  end

  def move_piece(from, _to)
    Board.at(from)
  end
end
