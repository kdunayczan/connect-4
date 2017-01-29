require_relative "slot.rb"
require "pry"

class Board

  attr_accessor :board

  def initialize(row_count, col_count)
    @row_count = row_count
    @col_count = col_count
    @board = Array.new(row_count) { Array.new(col_count) { Slot.new } }
    print_board
  end

  def print_row(row)
    print "| "
    (@board[0].size).times do |i|
      print "#{row[i].marker} "
    end
    print " |"
  end

  def print_board
    @board.each_with_index do |row,i|
      print_row(row)
      puts "\n"
    end
    columns = " "
    1.upto(@board[0].size) do |num|
      columns += " #{num}"
    end
    print columns
    puts
  end

  def on_board?(row, col)
    (row >=0 && row <= @row_count-1) && (col >=0 && col <= @col_count-1)
  end

  def four_consecutive?(coordinates, checking_method)
    marker_counter = 1
    index_counter = 1
    while marker_counter < 4
      if checking_method.call(coordinates, index_counter)
        marker_counter += 1
        if index_counter < 0
          index_counter -= 1
        else
          index_counter += 1
        end
      elsif index_counter < 0
        break
      else
        index_counter = -1
      end
    end
    return marker_counter == 4
  end

  def horizontal?(coordinates, index_counter)
    row = coordinates[0]
    col = coordinates[1]
    on_board?(row, col + index_counter) && @board[row][col].marker == @board[row][col + index_counter].marker
  end

  def vertical?(coordinates, index_counter)
    row = coordinates[0]
    col = coordinates[1]
    on_board?(row + index_counter, col) && @board[row][col].marker == @board[row + index_counter][col].marker
  end

  def forwardslash_diagonal?(coordinates, index_counter)
    row = coordinates[0]
    col = coordinates[1]
    on_board?(row - index_counter, col + index_counter) && @board[row][col].marker == @board[row - index_counter][col + index_counter].marker
  end

  def backslash_diagonal?(coordinates, index_counter)
    row = coordinates[0]
    col = coordinates[1]
    on_board?(row + index_counter, col + index_counter) && @board[row][col].marker == @board[row + index_counter][col + index_counter].marker
  end

  def check_for_winner(player, coordinates)
    if four_consecutive?( coordinates, method(:horizontal?) ) ||
      four_consecutive?( coordinates, method(:vertical?) ) ||
      four_consecutive?( coordinates, method(:backslash_diagonal?) ) ||
      four_consecutive?( coordinates, method(:forwardslash_diagonal?) )
      puts "#{player} Wins!"
      return true
    end
  end

end
