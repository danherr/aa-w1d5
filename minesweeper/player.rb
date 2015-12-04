
class Player
  def initialize
  end

  def prompt
    puts "Enter your move. The position followed by whether you want to (F)lag or (R)eveal it."
    input = []
    until input.length == 3
      input = STDIN.gets.chomp
      input = input.split(",")
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

end
