class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

end

class HumanPlayer < Player

  def move(engine, board, position)
    board.positions[position.to_i] = self.symbol
    board.display
    winner = engine.check_winner(board)
    if winner != "None"
      engine.show_winner(self.symbol, self.type)
    end
  end

  def type
    "Human"
  end

end

class BotPlayer < Player

  def move(engine, board, position=nil)
    puts ""
    puts "Bot #{self.symbol} is taking turn..."

    sleep 2

    position = check_priority(board)

    board.positions[position.to_i] = self.symbol

    winner = engine.check_winner(board)

    if winner != "None"
      puts ""
      board.display
      engine.show_winner(self.symbol, self.type)
    end

    puts ""
    board.display
  end

  def type
    "Bot"
  end

  private

  def check_priority(board)

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

    available_spaces = []
    board.positions.each do |position, value|
      if value != "X" && value != "O"
        available_spaces << position
      end
    end

    random_position = available_spaces.sample
    board.positions[random_position] = self.symbol

    return random_position
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