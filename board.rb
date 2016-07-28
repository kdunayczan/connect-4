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

  # def board_full?
  #   @board.marker.none? { |row| row.include?(" ") }
  # end

  def check_for_winner(coordinates)
    if horizontal_winner?(coordinates) || vertical_winner?(coordinates) || backslash_diagonal_winner?(coordinates) || forwardslash_diagonal_winner?(coordinates)
      puts "Winner!"
      return true
    end
  end

  def horizontal_winner?(coordinates)
    win_counter = 1
    index_counter = 1
    row = coordinates[0]
    col = coordinates[1]
    while win_counter < 4
      if on_board?(row, col+index_counter) && @board[row][col].marker == @board[row][col+index_counter].marker
        win_counter += 1
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
    return win_counter == 4
  end

  def vertical_winner?(coordinates)
    win_counter = 1
    index_counter = 1
    row = coordinates[0]
    col = coordinates[1]
    while win_counter < 4
      if on_board?(row+index_counter, col) && @board[row][col].marker == @board[row + index_counter][col].marker
        win_counter += 1
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
    return win_counter == 4
  end

  def backslash_diagonal_winner?(coordinates)
    win_counter = 1
    index_counter = 1
    row = coordinates[0]
    col = coordinates[1]
    while win_counter < 4
      if on_board?(row+index_counter, col+index_counter) && @board[row][col].marker == @board[row+index_counter][col+index_counter].marker
        win_counter += 1
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
    return win_counter == 4
  end

  def forwardslash_diagonal_winner?(coordinates)
    win_counter = 1
    index_counter = 1
    row = coordinates[0]
    col = coordinates[1]
    while win_counter < 4
      if on_board?(row-index_counter, col+index_counter) && @board[row][col].marker == @board[row-index_counter][col+index_counter].marker
        win_counter += 1
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
    return win_counter == 4
  end

end
