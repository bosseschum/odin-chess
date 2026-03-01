# frozen_string_literal: true

# Board class representing a chess board for a CLI chess game.
class Board
  attr_reader :grid

  def initialize(empty: false)
    @grid = Array.new(8) { Array.new(8) }
    @empty = empty
    @white_pieces = []
    @black_pieces = []
    setup_board unless @empty == true
  end

  def setup_board
    # Pawns
    8.times do |col|
      @white_pieces << place(Pawn.new(:white, [6, col]))
      @black_pieces << place(Pawn.new(:black, [1, col]))
    end

    # Rooks
    @white_pieces << place(Rook.new(:white, [7, 0]))
    @white_pieces << place(Rook.new(:white, [7, 7]))
    @black_pieces << place(Rook.new(:black, [0, 0]))
    @black_pieces << place(Rook.new(:black, [0, 7]))

    # Knights
    @white_pieces << place(Knight.new(:white, [7, 1]))
    @white_pieces << place(Knight.new(:white, [7, 6]))
    @black_pieces << place(Knight.new(:black, [0, 1]))
    @black_pieces << place(Knight.new(:black, [0, 6]))

    # Bishops
    @white_pieces << place(Bishop.new(:white, [7, 2]))
    @white_pieces << place(Bishop.new(:white, [7, 5]))
    @black_pieces << place(Bishop.new(:black, [0, 2]))
    @black_pieces << place(Bishop.new(:black, [0, 5]))

    # Queens
    @white_pieces << place(Queen.new(:white, [7, 3]))
    @black_pieces << place(Queen.new(:black, [0, 3]))

    # Kings
    @white_pieces << place(King.new(:white, [7, 4]))
    @black_pieces << place(King.new(:black, [0, 4]))
  end

  def place(piece)
    row, col = piece.position
    grid[row][col] = piece
  end

  def at(position)
    row, col = position
    @grid[row][col]
  end

  def remove_piece(piece)
    piece.color == :white ? @white_pieces.delete(piece) : @black_pieces.delete(piece)
  end

  def move_piece(from, to)
    piece = at(from)
    piece.position = to
    remove_piece(at(to)) if at(to) && at(to).color != piece.color
    place(piece)
    clear_square(from)
  end

  def out_of_bounds?(position)
    x, y = position
    x > 7 || x.negative? || y > 7 || y.negative?
  end

  def blocked?(piece, position)
    !at(position).nil? && at(position).color == piece.color
  end

  def filter_moves(piece, moves)
    moves.reject do |pos|
      out_of_bounds?(pos) || blocked?(piece, pos)
    end
  end

  def in_check?; end

  private

  def clear_square(position)
    row, col = position
    @grid[row][col] = nil
  end
end
