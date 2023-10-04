require 'pry-byebug'

NONE = 'NONE'.freeze

class GameBoard
  attr_accessor :board

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7].product([0, 1, 2, 3, 4, 5, 6, 7])
  end

  def build_graph(position)
    return NONE unless @board.include?(position)

    root = Node.new(position)
    root.tl1 = build_graph([position[0] - 1, position[1] + 2]) unless root.tl1
    root.tl2 = build_graph([position[0] - 2, position[1] + 1]) unless root.tl2
    root.tr1 = build_graph([position[0] + 1, position[1] + 2]) unless root.tr1
    root.tr2 = build_graph([position[0] + 2, position[1] + 1]) unless root.tr2
    root.bl1 = build_graph([position[0] - 1, position[1] - 2]) unless root.bl1
    root.bl2 = build_graph([position[0] - 2, position[1] - 1]) unless root.bl2
    root.br1 = build_graph([position[0] + 1, position[1] - 2]) unless root.br1
    root.br2 = build_graph([position[0] + 2, position[1] - 1]) unless root.br2
    root
  end
end

class Knight
  def knight_moves(start, finish)
    board = GameBoard.new
    root = board.build_graph(start)
    queue = [root]
    until queue.empty?
      current = queue.last
      return print_path(create_path(current)) if current.position == finish

      unless current.none?(tl1)
        current.tl1.parent = current
        queue.unshift(current.tl1)
      end
      unless current.none?(tl2)
        current.tl2.parent = current
        queue.unshift(current.tl2)
      end
      unless current.none?(tr1)
        current.tr1.parent = current
        queue.unshift(current.tr1)
      end
      unless current.none?(tr2)
        current.tr2.parent = current
        queue.unshift(current.tr2)
      end
      unless current.none?(bl1)
        current.bl1.parent = current
        queue.unshift(current.bl1)
      end
      unless current.none?(bl2)
        current.bl2.parent = current
        queue.unshift(current.bl2)
      end
      unless current.none?(br1)
        current.br1.parent = current
        queue.unshift(current.br1)
      end
      unless current.none?(br2)
        current.br2.parent = current
        queue.unshift(current.br2)
      end
      queue.pop
    end
  end

  def create_path(endpoint)
    path = [endpoint.position]
    current = endpoint
    until current.nil?
      current = current.parent
      path << current.position
    end
    path
  end

  def print_path(path)
    puts "You made it in #{path.length} moves! Here's your path: "
    path.each do |x, y|
      puts "[#{x}, #{y}]"
    end
    puts ''
  end
end

class Node
  attr_accessor :position, :parent, :tl1, :tl2, :tr1, :tr2, :bl1, :bl2, :br1, :br2

  def initialize(position)
    @position = position
    @parent = nil
    @tl1 = nil
    @tl2 = nil
    @tr1 = nil
    @tr2 = nil
    @bl1 = nil
    @bl2 = nil
    @br1 = nil
    @br2 = nil
  end

  def none?(child)
    child == NONE
  end
end

k = Knight.new

k.knight_moves([0, 0], [3, 3])
