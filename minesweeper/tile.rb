require 'colorize'

class Tile
  COLOR_HASH = {0 => :white, 1 => :light_blue , 2 => :cyan, 3 => :blue , 4 => :blue, 5 => :yellow , 6 => :yellow,7 => :light_red , 8 => :light_red}

  attr_writer :revealed

  attr_accessor :neighbor_bomb_count, :flagged

  def initialize(bomb, flagged = false, revealed = false)
      @bomb, @flagged, @revealed = bomb, flagged, revealed
      @neighbor_bomb_count = nil
  end

  def bomb?
    @bomb
  end

  def flagged?
    @flagged
  end

  def toggle_flag
    self.flagged = !self.flagged
  end

  def revealed?
    @revealed
  end

  def reveal
    self.revealed = true
  end

  def to_s(game_done)
    unless revealed? || game_done
      return flagged? ? "^".colorize(:white) : "_".colorize(:green)
    end
    return "B".colorize(:red) if bomb?
    "#{neighbor_bomb_count}".colorize(COLOR_HASH[neighbor_bomb_count])
  end

  private

  attr_writer :revealed

end
