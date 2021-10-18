class Node
  attr_reader :position, :parent

  Numbers = [[1, 2], [-2, -1], [-1, 2], [2, -1],
             [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  @@history = []

  def initialize(position, parent)
    @position = position
    @parent = parent
    @@history.push(position)
  end

  def children
    Numbers.map { |t| [@position[0] + t[0], @position[1] + t[1]] }
      .keep_if { |e| Node.valid?(e) }
      .reject { |e| @@history.include?(e) }
      .map { |e| Node.new(e, self) }
  end

  def self.valid?(position)
    position[0].between?(1, 8) && position[1].between?(1, 8)
  end
end

def display(nodes)
  display(nodes.parent) unless nodes.parent.nil?
  p "Position:"
  p nodes.position
end

def other_moves(start_pos, end_position)
  queue = []
  current_node = Node.new(start_pos, nil)
  until current_node.position == end_position
    current_node.children.each { |child| queue.push(child) }
    current_node = queue.shift
  end
  display(current_node)
end

other_moves([1, 1], [8, 8])
