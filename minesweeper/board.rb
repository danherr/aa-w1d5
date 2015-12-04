require_relative 'tile.rb'

class Board

  RELATIVE_NEIGHBORS = [[-1, -1],[1, 1],[-1,1],[1,-1],[0,1],[0,-1],[1,0],[-1,0]]

attr_accessor :grid
attr_reader :height, :width, :bomb_count
  def initialize(height = 9, width = 9, bomb_count = 10)
    @height = height
    @width = width
    @bomb_count = bomb_count
    @grid = nil
    populate
  end

  def populate
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



end
