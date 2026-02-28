# frozen_string_literal: true

describe King do
  let(:board) { Board.new }
  let(:king) { King.new(:white, [4, 4]) }
  before do
    board.place(king)
  end

  it 'moves one square vertically and horizontally' do
    moves = king.moves
    expect(moves).to include([4, 5], [4, 3], [5, 4], [3, 4])
  end

  it 'moves one square diagonally' do
    moves = king.moves
    expect(moves).to include([3, 3], [5, 5], [5, 3], [3, 5])
  end
end
