

class Tile

  attr_writer :flagged, :revealed

  attr_accessor :neighbor_bomb_count

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

  def revealed?
    @revealed
  end

  def reveal
    self.revealed = true
  end

  private

  attr_writer :revealed

end
