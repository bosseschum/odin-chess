# frozen_string_literal: true

require_relative 'modules/parsing'

# Game class for orchestrating a game of chess.
class Game
  include Parsing
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
    puts 'Choose a piece to move (by position). You have: '
    puts
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
    puts "\n"
    print 'Which piece do you want to move? '
    input = nil
    loop do
      input = take_input
      piece = board.at(input)
      moves = board.filter_moves(piece, piece.moves) if piece
      break if piece&.color == @current_player.color && moves && !moves.empty?

      puts 'Invalid piece, try again.'
    end
    input
  end

  def choose_move(position)
    piece = board.at(position)
    moves = board.filter_moves(piece, piece.moves)
    puts "#{piece} can move to: "
    print(moves.map { |pos| to_notation(pos) })
    puts

    input = nil
    loop do
      input = take_input
      break if moves.include?(input)

      puts 'Invalid move, try again.'
    end
    board.move_piece(position, input)
  end

  def game_over?
    @board.checkmate?(@current_player.color) || @board.stalemate?(@current_player.color)
  end

  def feedback
    if @board.checkmate?
      puts "Checkmate! #{color.capitalize} loses."
    elsif @board.stalemate?
      puts "Stalemate. #{color.capitalize} has to admit defeat."
    end
  end

  def take_input
    parse_input(gets.chomp.split(''))
  end
end
