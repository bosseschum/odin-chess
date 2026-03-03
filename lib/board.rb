# frozen_string_literal: true

# Board class representing a chess board for a CLI chess game.
class Board
  attr_reader :grid, :white_pieces, :black_pieces

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
    captured = (remove_piece(at(to)) if at(to) && at(to).color != piece.color)
    place(piece)
    clear_square(from)
    captured
  end

  def revert_move(current, original, captured)
    piece = at(current)
    piece.position = original
    unless captured.nil?
      @white_pieces << captured if captured.color == :white
      @black_pieces << captured if captured.color == :black
      place(captured)
    end
    place(piece)
    clear_square(current)
  end

  def simulate_move(from, to)
    captured = move_piece(from, to)
    check = yield
    revert_move(to, from, captured)
    check
  end

  def any_legal_moves?(color)
    king = find_king(color)
    if king.color == :white
      @white_pieces.any? do |piece|
        moves = filter_moves(piece, piece.moves)
        moves.any? do |move|
          simulate_move(piece.position, move) { !in_check?(king) }
        end
      end
    else
      @black_pieces.any? do |piece|
        moves = filter_moves(piece, piece.moves)
        moves.any? do |move|
          simulate_move(piece.position, move) { !in_check?(king) }
        end
      end
    end
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

  def in_check?(king)
    if king.color == :white
      @black_pieces.any? do |piece|
        filter_moves(piece, piece.moves).include?(king.position)
      end
    else
      @white_pieces.any? do |piece|
        filter_moves(piece, piece.moves).include?(king.position)
      end
    end
  end

  def checkmate?(color)
    king = find_king(color)
    !any_legal_moves?(color) && in_check?(king)
  end

  def stalemate?(color)
    king = find_king(color)
    !any_legal_moves?(color) && !in_check?(king)
  end

  def display_board
    row = 0
    @grid.each do |rank|
      print "#{row} "
      row += 1
      rank.each do |square|
        print "| #{square.nil? ? ' ' : square.symbol} |"
      end
      puts
    end
    print '    0    1    2    3    4    5    6    7'
    puts
  end

  private

  def clear_square(position)
    row, col = position
    @grid[row][col] = nil
  end

  def find_king(color)
    if color == :white
      @white_pieces.find { |k| k.is_a?(King) }
    else
      @black_pieces.find { |k| k.is_a?(King) }
    end
  end
end
