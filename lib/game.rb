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

  def take_turn
    board.display_board
    piece = choose_piece
    choose_move(piece)
    switch_player
  end

  def play
    puts "Let's play a game of chess. White begins."

    take_turn until game_over?
    feedback
  end

  private

  def choose_piece
    puts 'Choose a piece to move. You have: '
    if @current_player.color == :white
      board.white_pieces.each_with_index do |piece, index|
        print "#{piece} | "
        puts if ((index + 1) % 4).zero?
      end
    else
      board.black_pieces.each_with_index do |piece, index|
        print "#{piece} | "
        puts if ((index + 1) % 4).zero?
      end
    end
    take_input
  end

  def choose_move(position)
    piece = board.at(position)
    puts "#{piece} can move to: "
    print board.filter_moves(piece, piece.moves)
    move = take_input
    board.move_piece(position, move)
  end

  def game_over?
    @board.checkmate?(@current_player.color) || @board.stalemate?(@current_player.color)
  end

  def take_input
    gets.chomp.split('').map(&:to_i)
  end

  def feedback
    if @board.checkmate?
      puts "Checkmate! #{color.capitalize} loses."
    elsif @board.stalemate?
      puts "Stalemate. #{color.capitalize} has to admit defeat."
    end
  end
end
