class Knight
  attr_accessor :array, :tree

  def initialize
    @array = create_board
  end

  def create_board
    @array = Array.new(8) { Array.new(8) }
    @array.each_with_index do |line, lindex|
      line.each_with_index do |_column, cindex|
        @array[lindex][cindex] = Graph.new([lindex, cindex])
      end
    end
  end
  
  def shortest_path(initial_point, end_point, queue = [], passed_nodes = [])
    @tree = initial_point
    @tree.generate_branches
    if @tree.branches.any?(end_point)
      result_array = predecessor_tree(@tree)
      result_array = result_array.reverse
      result_array << end_point
    else
      passed_nodes << queue.slice!(0) unless queue.empty?
      @tree.branches.each do |coordinates|
        a = Graph.new(coordinates, @tree)
        if @tree.predecessor.nil?
          queue << a
        elsif @tree.predecessor.value != coordinates
          queue << a  unless queue.any?(a) || passed_nodes.any?(a)
        else
          next
        end
      end
      shortest_path(queue[0], end_point, queue, passed_nodes)
    end
  end

  def predecessor_tree(graph, result = [])
    if graph.predecessor.nil?
      result << graph.value
      result
    else
      result << graph.value
      predecessor_tree(graph.predecessor, result)
    end
  end
end

class Graph
  attr_accessor :branches, :predecessor, :value

  def initialize(value, predecessor = nil)
    @predecessor = predecessor
    @value = value
  end

  def generate_branches
    @branches = [[value[0] - 2, value[1] + 1], [value[0] - 1, value[1] + 2], [value[0] + 1, value[1] + 2],
                 [value[0] + 2, value[1] + 1], [value[0] + 2, value[1] - 1], [value[0] + 1, value[1] - 2],
                 [value[0] - 1, value[1] - 2], [value[0] - 2, value[1] - 1]]
    new_array = []
    @branches.each_with_index do |coordinates, _index|
      next unless coordinates[0] <= 7 && coordinates[1] <= 7

      new_array << coordinates if coordinates[0] >= 0 && coordinates[1] >= 0
    end
    @branches = new_array
  end
end

A = Knight.new
a = A.array[5][7]
b = [0,0]
print A.shortest_path(a, b)

