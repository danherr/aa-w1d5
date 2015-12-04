require "io/console"
require_relative 'interface'
#require_relative 'cursorable'


class CursorInterface < Interface

  attr_reader :cursor_pos, :board

  #Not our code: slightly edited "cursorable" code

  KEYMAP = {
    "r" => :reveal,
    "q" => :quit,
    "f" => :flag,
    "w" => :up,
    "a" => :left,
    "s" => :down,
    "d" => :right,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\u0003" => :ctrl_c,
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    when :flag
      "f"
    when :reveal
      "r"
    when :quit
      "q"
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def update_pos(diff)
    new_pos = [@cursor_pos[0] + diff[0], @cursor_pos[1] + diff[1]]
    @cursor_pos = new_pos if in_bounds?(new_pos)
  end





  def initialize(board = nil)
    @board = board
    @cursor_pos = [0, 0]
  end

    def build_grid
      @board.map.with_index do |row, i|
        build_row(row, i)
      end
    end

    def build_row(row, i)
      row.map.with_index do |piece, j|
        color_options = colors_for(i, j)
        piece.to_s.colorize(color_options) + " "
      end
    end

    def colors_for(i, j)
      if [i, j] == @cursor_pos
        bg = :light_black
      else
        bg = :black
      end
      { background: bg }
    end

    def render
      system("clear")
      puts "Hit R to reveal a square and F to flag it."
      puts "Q will Quit."
      build_grid.each { |row| puts row.join }
    end

    # Our code again. Entirely.

    def display(board)
      @board = board
      render
    end

    def prompt
      command = nil
      until command
        render
        command = get_input
      end

      [command, cursor_pos]
    end

    def in_bounds?(position)
      x,y = position
      x >= 0 && y >= 0 && !board[x].nil? && !board[x][y].nil?
    end



end
