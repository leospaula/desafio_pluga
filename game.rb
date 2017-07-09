require_relative "./engine"

class Game

  def start_game

    puts "\n >> CHOOSE THE GAME MODE: << \n"
    flag = true

    while flag do
      puts "\n 1 - Human x Human \n"
      puts "\n 2 - Human x Bot \n"
      puts "\n 3 - Bot x Bot \n"
      print "\n >> "
      ans = gets.chomp
      flag = true

      if (1..3).include?(ans.to_i)
        case ans.to_i
        when 1
          x_player = HumanPlayer.new("X")
          o_player = HumanPlayer.new("O")
        when 2
          x_player = HumanPlayer.new("X")
          o_player = BotPlayer.new("O")
        when 3
          x_player = BotPlayer.new("X")
          o_player = BotPlayer.new("O")
        end
        flag = false
      else
        puts "\nInvalid input, Please choose number between 1 to 3\n"
        flag = true
      end
    end

    engine = Engine.new
    
    board = Board.new
    board.show_positions

    engine.start(x_player, o_player, board)

    engine.stop
  end
end

game = Game.new
game.start_game