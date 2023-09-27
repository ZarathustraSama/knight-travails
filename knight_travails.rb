class GameBoard
  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7].product([0, 1, 2, 3, 4, 5, 6, 7])
  end
end

class Knight
  attr_accessor :position, :all_possible_moves
  def initialize(position)
    @position = position
    @moves = check_moves(position)
  end

  def check_moves(position)
    moves = []
    moves << [position[0] + 1, position[1] + 2] unless position[0] + 1 > 7 || position[1] + 2 > 7
    moves << [position[0] + 2, position[1] + 1] unless position[0] + 1 > 7 || position[1] + 2 > 7
    moves << [position[0] - 1, position[1] - 2] unless position[0] - 1 < 0 || position[1] - 2 < 0
    moves << [position[0] - 2, position[1] - 1] unless position[0] - 1 < 0 || position[1] - 2 < 0
    moves
  end

  def knight_moves(start, finish)

  end
end