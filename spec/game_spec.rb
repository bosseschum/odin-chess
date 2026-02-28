# frozen_string_literal: true

describe Game do
  xit 'switches player after a valid move' do
    game = Game.new
    current = game.current_player
    game.switch_player
    expect(game.current_player).not_to eq(current)
  end
end
