# frozen_string_literal: true

# Game class for orchestrating a game of chess.
class Game
  attr_reader :board, :players, :current_player

  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players.first
  end

  def switch_player
    @current_player = @current_player.color == :white ? players.last : players.first
  end

  def take_turn(player); end

  def game_over?
    @board.checkmate?(@current_player.color) || @board.stalemate?(@current_player.color)
  end

  private

  def choose_piece
    puts 'Choose a piece to move. You have: '
    if @current_player.color == :white
      board.white_pieces.each do |piece|
        puts "#{piece} | "
      end
    else
      board.black_pieces.each do |piece|
        puts "#{piece} | "
      end
    end
  end

  def display_moves
    position = gets.chomp.downcase
    piece = board.at(position)
    puts "#{piece} can move to: "
    print piece.moves
  end
end
