# frozen_string_literal: true

describe Rook do
  let(:board) { Board.new(empty: true) }
  let(:rook) { Rook.new(:white, [4, 4]) }

  before do
    board.place(rook)
  end

  it 'tracks starting position' do
    rook = Rook.new(:black, [0, 7])
    expect(rook.starting_position).to eq([0, 7])
  end

  it 'tracks moved state' do
    rook = Rook.new(:white, [0, 0])
    expect(rook.moved).to be false
  end

  it 'moves vertivally and horizontally' do
    moves = rook.moves(board)

    expect(moves).to include([4, 7], [4, 0], [0, 4], [7, 4])
  end

  it 'stops at allied piece' do
    blocker = Pawn.new(:white, [4, 6])
    board.place(blocker)

    moves = rook.moves(board)
    expect(moves).not_to include([4, 7])
  end

  it 'can capture enemy pieces' do
    enemy = Pawn.new(:black, [4, 6])
    board.place(enemy)

    moves = rook.moves(board)
    expect(moves).to include([4, 6])
    expect(moves).not_to include([4, 7])
  end
end
