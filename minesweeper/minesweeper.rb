require 'colorize'
require_relative 'board.rb'
require_relative 'interface.rb'


class Minesweeper
attr_reader :board, :interface

  def initialize(interface, board = Board.new)
    @board = board
    @interface = interface
  end

  def play
    take_turn until board.finished

    interface.display(board.display)

    if board.won
      puts "Good Job. You Won."
    else
      puts "You blew up. Your family will now starve."
    end
  end

  def take_turn

    interface.display(board.display)
    turn = interface.prompt # ['r', [0,0]]
    pos = turn[1]
    action = turn[0]
    if !board.in_bounds(pos) || board[pos].revealed?
      interface.yell_at
    elsif action == 'r'
      board.reveal(pos)
    elsif action == 'f'
      board[pos].toggle_flag
    elsif action == 'q'
      raise "Quit"
    else
      interface.yell_about_action
    end
  end



end
