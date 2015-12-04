require 'colorize'
require_relative 'board.rb'
require_relative 'player.rb'


class Minesweeper
attr_reader :board, :player

  def initialize(player, board = Board.new)
    @board = board
    @player = player
  end

  def play
    take_turn until board.finished

    display

    if board.won
      puts "Good Job. You Won."
    else
      puts "You blew up. Your family will now starve."
    end
  end

  def take_turn

    display
    turn = player.prompt # ['r', [0,0]]
    pos = turn[1]
    action = turn[0]
    if board[pos].revealed? || !board.in_bounds(pos)
      player.yell_at
    elsif action == 'r'
      board.reveal(pos)
    elsif action == 'f'
      board[pos].toggle_flag
    elsif action == 'q'
      raise "Quit"
    else
      player.yell_about_action
    end
  end

  def display
    board_arr = board.display
    puts "   "  + (0...board.width).to_a.map { |num|
      num < 10 ? "#{num}  " : "#{num} "}.join

    board_arr.each_with_index do |row, i|
      i >= 10 ? spaces = " " : spaces = "  "
      row = row.join("  ")
      puts i.to_s + "#{spaces}#{row} ".colorize(:background => :black)
    end
  end


end
