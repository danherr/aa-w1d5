require_relative 'tile.rb'

class Board
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

end
