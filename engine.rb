require_relative "./board"
require_relative "./player"

class Engine

  POSITION = %w[1 2 3 4 5 6 7 8 9]

  def start(x_player, o_player, board)

    puts "\n >> PLEASE SEE THE POSITIONS OF THE BOARD << \n\n"
    flag = true

    while flag do
      print "Who will play first? [ X / O ]: "
      ans = gets.chomp

      if %w[X x O o].include?(ans)
        if %w[X x].include?(ans)
          current_player = x_player
        else
          current_player = o_player
        end
        flag = false
      else
        puts "\nInvalid input, Please choose X or O\n"
        flag = true
      end
    end

    (1..9).each do
      if current_player == x_player
        play(current_player, board)
        current_player = o_player
      else
        play(current_player, board)
        current_player = x_player
      end
    end

  end

  def stop
    puts "\n************* Match Draw ****************\n\n"
  end

  def play(current_player, board)
    if current_player.type == "Human"
      flag = true

      while flag do
        puts ""
        print "Player #{current_player.symbol}: Where do want to move? <1-9>: "
        position = gets.chomp

        if !POSITION.include?(position)
          puts "\nInvalid input, Please choose number between 1 to 9\n"
          flag = true
        elsif %w[X O].include?board.positions[position]
          puts "\nPosition already occupied, Please choose another number...\n"
          flag = true
        else
          flag = false
        end
      end

      current_player.move(self, board, position)
    else
      current_player.move(self, board)
    end
  end

  def check_winner(board)
    x_count = 0
    o_count = 0
    Board::WINNING_PLACES.each do |winning_place|
      winning_place.each do |index|
        if board.positions[index] == "X"
          x_count = x_count + 1
        elsif board.positions[index] == "O"
          o_count = o_count + 1
        end
      end
      if x_count == 3 or o_count == 3
        break
      else
        x_count = 0
        o_count = 0
      end
    end
    if x_count == 3
      return "X won"
    elsif o_count == 3
      return "O won"
    end
    return "None"
  end

  def show_winner(symbol, type)
    puts "\n*************| Result |*************"
    if type == "Human"
      puts "Congratulation!!!, player #{symbol} won the game\n\n"
    else
      puts "Bot #{symbol} won the game\n\n"
    end
    exit
  end

end