require 'pry-byebug'

class GameBoard
  attr_accessor :board, :knight_graph

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7].product([0, 1, 2, 3, 4, 5, 6, 7])
  end

  def build_graph(position, path = [position])
    return nil unless @board.include?(position)
    return nil if path.count(position) > 1

    root = Node.new(position)
    root.tl1 = build_graph([position[0] - 1, position[1] + 2], path << [position[0] - 1, position[1] + 2])
    root.tl2 = build_graph([position[0] - 2, position[1] + 1], path << [position[0] - 2, position[1] + 1])
    root.tr1 = build_graph([position[0] + 1, position[1] + 2], path << [position[0] + 1, position[1] + 2])
    root.tr2 = build_graph([position[0] + 2, position[1] + 1], path << [position[0] + 2, position[1] + 1])
    root.bl1 = build_graph([position[0] - 1, position[1] - 2], path << [position[0] - 1, position[1] - 2])
    root.bl2 = build_graph([position[0] - 2, position[1] - 1], path << [position[0] - 2, position[1] - 1])
    root.br1 = build_graph([position[0] + 1, position[1] - 2], path << [position[0] + 1, position[1] - 2])
    root.br2 = build_graph([position[0] + 2, position[1] - 1], path << [position[0] + 2, position[1] - 1])
    root
  end
end

class Knight
  def knight_moves(start, finish)
    board = GameBoard.new
    root = board.build_graph(start)
    queue = [root]
    path = []
    until queue.empty?
      current = queue.last
      path << current.position unless current.nil?
      return print_path(path) if current.position == finish

      queue.unshift(current.tl1) unless current.tl1.nil? || path.include?(current.tl1)
      queue.unshift(current.tl2) unless current.tl2.nil? || path.include?(current.tl2)
      queue.unshift(current.tr1) unless current.tr1.nil? || path.include?(current.tr1)
      queue.unshift(current.tr2) unless current.tr2.nil? || path.include?(current.tr2)
      queue.unshift(current.bl1) unless current.bl1.nil? || path.include?(current.bl1)
      queue.unshift(current.bl2) unless current.bl2.nil? || path.include?(current.bl2)
      queue.unshift(current.br1) unless current.br1.nil? || path.include?(current.br1)
      queue.unshift(current.br2) unless current.br2.nil? || path.include?(current.br2)
      queue.pop
    end
  end

  def print_path(path)
    puts "You made it in #{path.length} moves! Here's your path: "
    path.each do |x, y|
      puts "[#{x}, #{y}]"
    end
  end
end

# The vertex where the position of the knight is connected to the top/bottom left/right tiles(t/b l/r)
class Node
  attr_accessor :position, :tl1, :tl2, :tr1, :tr2, :bl1, :bl2, :br1, :br2

  def initialize(position)
    @position = position
    @tl1 = nil
    @tl2 = nil
    @tr1 = nil
    @tr2 = nil
    @bl1 = nil
    @bl2 = nil
    @br1 = nil
    @br2 = nil
  end
end
