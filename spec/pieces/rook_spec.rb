# frozen_string_literal: true

describe Rook do
  let(:board) { Board.new }
  let(:rook) { Rook.new(:white, [4, 4]) }

  before do
    board.place(rook)
  end

  it 'moves vertically and horizontally' do
    moves = rook.moves

    expect(moves).to include([4, 7], [4, 0], [0, 4], [7, 4])
  end

  xit 'stops at allied piece' do
    blocker = Pawn.new(:white, [4, 6])
    board.place(blocker)

    moves = rook.moves(board)
    expect(moves).not_to include([4, 7])
  end

  xit 'can capture enemy pieces' do
    enemy = Pawn.new(:black, [4, 6])
    board.place(enemy)

    moves = rook.moves(board)
    expect(moves).to include([4, 6])
    expect(moves).not_to include([4, 7])
  end
end
