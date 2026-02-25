# frozen_string_literal: true

class Game
  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players.first
  end
end
