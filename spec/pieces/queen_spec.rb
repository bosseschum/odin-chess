# frozen_string_literal: true

describe Queen do
  let(:board) { Board.new }
  let(:queen) { Queen.new(:white, [4, 4]) }
  before do
    board.place(queen)
  end

  it 'moves vertically and horizontally' do
    moves = queen.moves
    expect(moves).to include([4, 7], [4, 0], [0, 4], [7, 4])
  end

  it 'moves diagonally' do
    moves = queen.moves
    expect(moves).to include([0, 0], [1, 1], [2, 2], [3, 3],
                             [5, 5], [6, 6], [7, 7], [3, 5],
                             [2, 6], [1, 7], [5, 3], [6, 2],
                             [7, 1])
  end
end
