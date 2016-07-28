require_relative "board.rb"
require "pry"

class Connect_4

  attr_accessor :game_board, :player_1_marker, :player_2_marker

  def initialize
    @game_board = Board.new(10, 10)
    @player_1_marker = "X"
    @player_2_marker = "O"
    get_players_names
  end

  def get_players_names
    puts "What is Player 1's name?"
    @player_1_name = gets.chomp.upcase
    puts "What is Player 2's name?"
    @player_2_name = gets.chomp.upcase
    puts "Hello #{@player_1_name} and #{@player_2_name}. Let's play Connect-4!"
  end

  def place_marker(player)
    puts "Select a column to drop your marker."
    move = gets.chomp.to_i - 1
    (@game_board.board.length-1).downto(0) do |row|
      if !@game_board.board[row][move].has_marker? && @game_board.on_board?(row, move)
       # && !@game_board.board_full?
        @game_board.board[row][move].marker = player
        @last_move = [row,move]
        return true
      end
    end
  end

  def play
    while true
      puts @player_1_name + "'s turn"
      place_marker(@player_1_marker)
      @game_board.print_board
      break if @game_board.check_for_winner(@last_move)
      puts @player_2_name + "'s turn"
      place_marker(@player_2_marker)
      @game_board.print_board
      break if @game_board.check_for_winner(@last_move)
    end
  end



  # Players turn
    # check if valid input: col = 1-10
    # if valid input, check if column has empty space
    # if colum has space, place maker

  # 4 in a row vertically
  # 4 in a row horizontally
  # 4 in a row diagonally
  # winner
  # game over
  # tie game

  # play
  # play again


end

game = Connect_4.new
game.play
