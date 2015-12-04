require_relative 'board.rb'
# require_relative 'player.rb'


class Minesweeper
attr_reader :board, :player

  def initialize(player, board = Board.new)
    @board = board
    @player = player
  end

  def play

  end

  def take_turn
    
  end

  def display
    board_arr = board.display
    puts "   "  + (0...board.width).to_a.map { |num|
      num < 10 ? "#{num}  " : "#{num} "}.join

    board_arr.each_with_index do |row, i|
      i >= 10 ? spaces = " " : spaces = "  "
      row = row.join("  ")
      puts "#{i}#{spaces}#{row}"
    end
  end


end
