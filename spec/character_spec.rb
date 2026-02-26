# frozen_string_literal: true

describe Character do
  let(:char) { Character.new(:white, [4, 4]) }

  it 'stores color' do
    expect(char.color).to eq(:white)
  end

  context 'The moved state' do
    it 'equals false at start' do
      rook = Rook.new(:white, [0, 0])
      expect(rook.moved).to be false
    end

    it 'equals true after first move' do
      pawn = Pawn.new(:white, [0, 3])
      expect(pawn.moved).to be true
    end
  end

  it 'detects enemy pieces' do
    enemy = Character.new(:black, [4, 5])
    ally = Character.new(:white, [4, 3])

    expect(char.enemy?(enemy)).to be true
    expect(char.enemy?(ally)).to be false
  end
end
