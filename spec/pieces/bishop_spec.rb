# frozen_string_literal: true

describe Bishop do
  let(:board) { Board.new }
  let(:bishop) { Bishop.new(:white, [4, 4]) }

  before do
    board.place(bishop)
  end

  it 'moves diagonally in four directions' do
    moves = bishop.moves

    expect(moves).to match_array([[0, 0], [1, 1], [2, 2], [3, 3],
                                  [5, 5], [6, 6], [7, 7], [3, 5],
                                  [2, 6], [1, 7], [5, 3], [6, 2],
                                  [7, 1]])
  end
end
