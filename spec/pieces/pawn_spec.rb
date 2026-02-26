# frozen_string_literal: true

describe Pawn do
  it 'can double step' do
    pawn = Pawn.new(:white, [0, 1])
    expect(pawn.can_double_step).to be true
  end

  it 'can not double step' do
    pawn = Pawn.new(:black, [0, 5])
    expect(pawn.can_double_step).to be false
  end
end
