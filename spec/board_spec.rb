# frozen_string_literal: true

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it '#creates an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |r| r.size == 8 }).to be true
    end
  end

  describe '#setup_board' do
    it 'places white pawns on rank 2' do
      pawns = board.grid[6].compact
      expect(pawns.all? { |p| p.is_a?(Pawn) && p.color == :white }).to be true
    end

    it 'places the white King on E1' do
      king = board.at([7, 4])
      expect(king).to be_a(King)
    end
  end

  describe '#move_piece' do
    it 'moves a piece to an empty square' do
      board = Board.new(empty: true)
      rook = Rook.new(:white, [0, 0])
      board.place(rook)

      board.move_piece([0, 0], [0, 5])
      expect(board.at([0, 5])).to eq(rook)
    end

    it 'clears the previous square' do
      board = Board.new(empty: true)
      rook = Rook.new(:white, [7, 7])
      board.place(rook)

      board.move_piece([7, 7], [7, 0])
      expect(board.at([7, 7])).to be_nil
    end
  end

  describe '#filter_moves' do
    knight = Knight.new(:white, [7, 1])
    pawn = Pawn.new(:white, [5, 2])
    enemy = Pawn.new(:black, [5, 0])
    moves = knight.moves
    it 'filters out of bounds moves' do
      filtered_moves = board.filter_moves(knight, moves)
      expect(filtered_moves).to_not include([8, 3])
    end

    it 'filters squares blocked by allied pieces' do
      board.place(pawn)
      filtered_moves = board.filter_moves(knight, moves)
      expect(filtered_moves).to_not include([5, 2])
    end

    it 'does not filter squares with enemy pieces' do
      board.place(enemy)
      filtered_moves = board.filter_moves(knight, moves)
      expect(filtered_moves).to include([5, 0])
    end
  end

  describe '#in_check?' do
    board = Board.new(empty: true)
    let(:king) { King.new(:black, [7, 7]) }
    context 'When the king is in danger' do
      it 'returns true' do
        rook = Rook.new(:white, [7, 1])
        board.place(rook)
        board.white_pieces << rook
        board.place(king)
        expect(board.in_check?(king)).to eq true
        board.remove_piece(rook)
      end
    end

    context 'When the king is not in danger' do
      it 'returns false' do
        rook = Rook.new(:white, [6, 2])
        board.place(rook)
        board.white_pieces << rook
        board.place(king)
        expect(board.in_check?(king)).to eq false
      end
    end
  end

  describe '#any_legal_moves?' do
    let(:board) { Board.new(empty: true) }
    let(:king) { King.new(:white, [7, 4]) }
    before do
      board.place(king)
      board.white_pieces << king
    end

    context 'When there are legal moves left' do
      it 'returns true' do
        expect(board.any_legal_moves?(:white)).to be true
      end
    end

    context 'When there are no legal moves left' do
      it 'returns false' do
        rook1 = Rook.new(:black, [7, 0])
        board.place(rook1)
        rook2 = Rook.new(:black, [6, 7])
        board.place(rook2)
        board.black_pieces << rook1
        board.black_pieces << rook2
        expect(board.any_legal_moves?(:white)).to be false
      end
    end
  end

  describe '#checkmate?' do
    let(:board) { Board.new(empty: true) }
    let(:king) { King.new(:white, [7, 4]) }
    before do
      board.place(king)
      board.white_pieces << king
    end

    context 'When the king is in check and no legal moves are left' do
      it 'returns true' do
        rook1 = Rook.new(:black, [7, 0])
        board.place(rook1)
        rook2 = Rook.new(:black, [6, 7])
        board.place(rook2)
        board.black_pieces << rook1
        board.black_pieces << rook2
        expect(board.checkmate?(:white)).to be true
      end
    end

    context 'When the king is in check but there are legal moves' do
      it 'returns false' do
        rook = Rook.new(:black, [6, 7])
        board.place(rook)
        board.black_pieces << rook
        expect(board.checkmate?(:white)).to be false
      end
    end
  end

  describe '#stalemate?' do
    let(:board) { Board.new(empty: true) }
    let(:king) { King.new(:white, [7, 0]) }
    before do
      board.place(king)
      board.white_pieces << king
    end

    context 'When the king is not in check and no legal moves are left' do
      it 'returns true' do
        rook1 = Rook.new(:black, [6, 4])
        board.place(rook1)
        rook2 = Rook.new(:black, [5, 1])
        board.place(rook2)
        board.black_pieces << rook1
        board.black_pieces << rook2
        print board.any_legal_moves?(:white)
        expect(board.stalemate?(:white)).to be true
      end
    end

    context 'When the king is not in check and there are legal moves left' do
      it 'returns false' do
        expect(board.stalemate?(:white)).to be false
      end
    end
  end
end
