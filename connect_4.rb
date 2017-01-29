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
    puts ""
    puts "What is Player 1's name?"
    @player_1_name = gets.chomp.upcase
    puts ""
    puts "What is Player 2's name?"
    @player_2_name = gets.chomp.upcase
    puts ""
    puts "Hello #{@player_1_name} and #{@player_2_name}. Let's play Connect-4!"
    puts ""
  end

  def place_marker(player)
    valid = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    puts "Select a column to drop your marker."
    move = gets.chomp.to_i - 1 
    while !valid.include?(move) do
      puts "Please select a valid column"
      move = gets.chomp.to_i - 1 
    end
    (@game_board.board.length-1).downto(0) do |row|
      if !@game_board.board[row][move].has_marker? && @game_board.on_board?(row, move)
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
      break if @game_board.check_for_winner(@player_1_name, @last_move)
      puts @player_2_name + "'s turn"
      place_marker(@player_2_marker)
      @game_board.print_board
      break if @game_board.check_for_winner(@player_2_name, @last_move)
    end
  end

end

game = Connect_4.new
game.play
