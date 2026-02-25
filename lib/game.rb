# frozen_string_literal: true

# Game class for orchestrating a game of chess.
class Game
  attr_reader :board, :players, :current_player

  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players.first
  end
end
