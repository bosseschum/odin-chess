# frozen_string_literal: true

describe Character do
  let(:char) { Character.new(:white, [4, 4]) }

  it 'stores color' do
    expect(char.color).to eq(:white)
  end

  it 'detects enemy pieces' do
    enemy = Character.new(:black, [4, 5])
    ally = Character.new(:white, [4, 3])

    expect(char.enemy?(enemy)).to be true
    expect(char.enemy?(ally)).to be false
  end
end
