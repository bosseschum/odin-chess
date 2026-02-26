# frozen_string_literal: true

describe Board do
  subject(:board) { described_class.new }

  desscribe '#initialize' do
    it '#creates an 8x8 grid' do
      expect(board.grid.size).to eq(8)
      expect(board.grid.all? { |r| r.size == 8 }).to be true
    end
  end

  describe '#setup_board' do
    it '#places white pawns on rank 2' do
      pawns = board.grid[6].compact
      expect(pawns.all? { |p| p.is_a?(Pawn) && p.color == :white }).to be true
    end
  end

  describe '#move_piece' do
    it 'moves a piece to an empty square' do
      board = Board.new(empty: true)
      rook = Rook.new(:white, [0, 0])
      board.place(rook)

      board.move_piece([0, 0], [0, 5])
      expect(board.at(0, 5)).to eq(rook)
      expect(board.at(0, 0)).to be_nil
    end
  end
end
