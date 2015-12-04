
class Interface
  def initialize
  end

  def prompt
    puts "Enter your move. The position followed by whether you want to (F)lag or (R)eveal it."
    input = []
    until input.length == 3
      input = STDIN.gets.chomp
      input = input.split(",")
      if input.include?("q")
        raise "Quit"
      end
    end

    pos = [input[0].to_i , input[1].to_i]
    action = input[2].downcase

    [action,pos]
  end

  def yell_at
    puts "Enter a valid position!"
  end

  def yell_about_action
    puts "The only valid actions are F, R and Q."
  end

  def display(board_arr)
    puts "   "  + (0...board_arr[0].length).to_a.map { |num|
      num < 10 ? "#{num}  " : "#{num} "}.join

    board_arr.each_with_index do |row, i|
      i >= 10 ? spaces = " " : spaces = "  "
      row = row.join("  ")
      puts i.to_s + "#{spaces}#{row} ".colorize(:background => :black)
    end
  end

end
