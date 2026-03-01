# frozen_string_literal: true

describe Pawn do
  let(:pawn) { described_class.new(:white, [3, 6]) }

  it 'can double step on its first move' do
    expect(pawn.moves).to match_array([[3, 5], [3, 4]])
  end

  it 'cannot double step after moving' do
    pawn.mark_moved
    expect(pawn.moves).not_to include([3, 4])
  end

  it 'moves only one step forward' do
    pawn.mark_moved
    expect(pawn.moves).to match_array([[3, 5]])
  end

  it 'captures diagonally' do
    expect(pawn.captures).to match_array([[2, 5], [4, 5]])
  end
end
