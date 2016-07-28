require "pry"

class Slot

  attr_accessor :marker

  def initialize
    @marker = " "
  end

  def has_marker?
    !@marker.strip.empty?
  end

  def place_marker(symbol) #"X" "O" or "Black" "Red"
    @marker = symbol
  end

end
