require_relative 'tile.rb'

class Board

  RELATIVE_NEIGHBORS = [[-1, -1],[1, 1],[-1,1],[1,-1],[0,1],[0,-1],[1,0],[-1,0]]

attr_accessor :grid, :finished, :revealed_spaces, :won
attr_reader :height, :width, :bomb_count
  def initialize(height = 9, width = 9, bomb_count = 10)
    @height = height
    @width = width
    @bomb_count = bomb_count
    @finished = false
    @won = false
    @revealed_spaces = 0
    @grid = nil

    populate
    compute_bomb_count

  end

  def populate
    self.revealed_spaces = 0
    self.grid = Array.new(height) { Array.new(width) }
    all_positions = []
    height.times do |row|
      width.times do |col|
        all_positions << [row, col]
      end
    end
    all_positions.shuffle!
    bomb_positions = all_positions.take(bomb_count)
    safe_positions = all_positions.drop(bomb_count)
    bomb_positions.each do |position|
      x, y = position
      grid[x][y] = Tile.new(true)
    end
    safe_positions.each do |position|
      x, y = position
      grid[x][y] = Tile.new(false)
    end

  end

  def neighbor_positions(position)
    all_neighbors = RELATIVE_NEIGHBORS.map do |rel_pos|
      x,y = position
      dx, dy = rel_pos
      [x + dx, y + dy]
    end

    all_neighbors.select {|pos| in_bounds(pos)}
  end

  def in_bounds(position)
    x,y = position

    x >= 0 && y >= 0 && x < height && y < width
  end

  def compute_bomb_count
    grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        neighbors = neighbor_positions([i,j])

        bombs = 0

        neighbors.each {|neighbor| self[neighbor].bomb? ? bombs += 1 : nil}

        tile.neighbor_bomb_count = bombs
      end
    end
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def display
    grid.map do |row|
      row.map{|tile| tile.to_s}
    end
  end

  def reveal_neighbors_recursively(pos)
    unrevealed_neighbors(pos).each do |neighbor_pos|
        reveal(neighbor_pos)
    end
  end

  def reveal(pos)
    unless self[pos].revealed?
      self[pos].reveal
      self.revealed_spaces += 1
      if self[pos].bomb?
        self.finished = true
        self.won = false
      elsif revealed_spaces + bomb_count == height * width
        self.finished = true
        self.won = true
      end
      if self[pos].neighbor_bomb_count == 0
        reveal_neighbors_recursively(pos)
      end
    end
  end

  def unrevealed_neighbors(pos)
    neighbor_positions(pos).reject do |pos|
      self[pos].revealed?
    end
  end


end
