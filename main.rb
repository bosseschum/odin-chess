# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/character'
require_relative 'lib/player'
require_relative 'lib/pieces/king'
require_relative 'lib/pieces/queen'
require_relative 'lib/pieces/pawn'
require_relative 'lib/pieces/rook'
require_relative 'lib/pieces/bishop'
require_relative 'lib/pieces/knight'

game = Game.new
game.play
