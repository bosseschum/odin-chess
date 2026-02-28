# frozen_string_literal: true

describe Knight do
  let(:knight) { Knight.new(:white, [5, 2]) }
  it 'can move eight ways' do
    expect(knight.moves).to match_array([[3, 1], [3, 3], [4, 0], [4, 4], [6, 0], [6, 4], [7, 1], [7, 3]])
  end
end
