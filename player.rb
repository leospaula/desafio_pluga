class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def move(board, position, engine)
    board.positions_with_values[position] = self.symbol
    board.display
    winner = engine.check_winner(board)
    if winner != "None"
      engine.show_winner(self.symbol)
    end
  end

  def best_move(board, engine)
    puts ""
    puts "Robot (O player) is taking turn..."

    sleep 2

    position = check_priority(board)

    board.positions_with_values[position] = "O"

    winner = engine.check_winner(board)

    if winner != "None"
      puts ""
      board.display
      engine.show_winner(self.symbol)
    end

    puts ""
    board.display
  end

  private

  def check_priority(board)
    flag = true

    x_symbol = "X"
    o_symbol = "O"

    o_position = position_priority(board, o_symbol)

    if !o_position.nil?
      return o_position
    end

    x_position = position_priority(board, x_symbol)

    if !x_position.nil?
      return x_position
    end

    while flag do
      random_position = 1 + rand(8)
      if board.positions[random_position] != "X" and board.positions[random_position] != "O"
        board.positions[random_position] = "O"
        return random_position
        flag false
      end
    end
  end

  def position_priority(board, symbol)
    Board::WINNING_PLACES.each do |winning_place|
      priority_positions_order = [[0, 1, 2], [0, 2, 1], [1, 2, 0]]
      priority_positions_order.each do |priority|
        if (board.positions[winning_place[priority[0]]] == symbol) and (board.positions[winning_place[priority[1]]] == symbol)
          if board.positions[winning_place[priority[2]]] == " "
            return winning_place[priority[2]]
          end
        end
      end
    end
    return nil
  end

end