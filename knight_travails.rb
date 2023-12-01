K_MOVES = [[1, 2], [2, 1], [-1, 2], [-2, 1], [-1, -2], [-2, -1], [1, -2], [2, -1]]
BOARD = [0, 1, 2, 3, 4, 5, 6, 7].product([0, 1, 2, 3, 4, 5, 6, 7])

class Knight
  def knight_moves(start, finish)
    root = Node.new(start)
    queue = [root]
    until queue.empty? do
      current = queue.last
      return print_path(create_path(current)) if current.position == finish

      p = current.position
      current.children = K_MOVES.map { |move|
        Node.new([p[0] + move[0], p[1] + move[1]]) if valid_move?(current, [p[0] + move[0], p[1] + move[1]])
      }
      .compact
      .each do |child|
        child.parent = current
        queue.unshift(child)
      end
      queue.pop
    end
  end

  def valid_move?(current, position)
    until current.parent.nil?
      current = current.parent
      return false if current.position == position
    end
    BOARD.include?(position)
  end

  def create_path(node)
    path = [node.position]
    until node.parent.nil?
      node = node.parent
      path.unshift(node.position)
    end
    path
  end

  def print_path(path)
    puts "You made it in #{path.length - 1} moves! Here's your path: "
    path.each do |x, y|
      puts "[#{x}, #{y}]"
    end
    puts ''
  end
end

class Node
  attr_accessor :position, :parent, :children

  def initialize(position)
    @position = position
    @parent = nil
    @children = nil
  end
end

k = Knight.new
k.knight_moves([3, 3], [4, 3])
