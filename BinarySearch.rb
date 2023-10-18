class Tree
  attr_accessor :root

  def initialize(array)
    array = merge_sort(array)
    @root = build_tree(array)
  end

  def rebalance
    array = level_order_rec
    array = merge_sort(array)
    @root = build_tree(array)
  end  
    
  def balance?(node = @root)
    height_left = 0
    height_right = 0
    height_left = height(node.left_node) unless node.left_node.nil?
    height_right = height(node.right_node) unless node.right_node.nil?
    if height_left == height_right || height_left + 1 == height_right || height_right + 1 == height_left
      if height_left == 0 || height_right == 0
        nil
      else
        balance?(node.left_node)
        balance?(node.right_node)
        bool = true
      end
    else
      false
    end
  end

  def height_node(value, node = @root, height = height())
    if value < node.value
      height_node(value, node.left_node, height - 1)
    elsif value > node.value
      height_node(value, node.right_node, height - 1)
    elsif value = node.value
      height
    end
  end

  def height(node = @root, height = 0, result = [])
    result << height
    height(node.left_node, height + 1, result) unless node.left_node.nil?
    height(node.right_node, height + 1, result) unless node.right_node.nil?
    result.max
  end

  def depth(value, node = @root, d = 0)
    if value < node.value
      depth(value, node.left_node, d + 1)
    elsif value > node.value
      depth(value, node.right_node, d + 1)
    elsif value = node.value
      d
    end
  end

  def preorder(node = @root, result_array = [], &block)
    result_array << node.value
    yield(node.value) if block_given?
    preorder(node.left_node, result_array, &block) unless node.left_node.nil?
    preorder(node.right_node, result_array, &block) unless node.right_node.nil?
    result_array
  end

  def inorder(node = @root, result_array = [], &block)
    inorder(node.left_node, result_array, &block) unless node.left_node.nil?
    result_array << node.value
    yield(node.value) if block_given?
    inorder(node.right_node, result_array, &block) unless node.right_node.nil?
    result_array
  end

  def postorder(node = @root, result_array = [], &block)
    postorder(node.left_node, result_array, &block) unless node.left_node.nil?
    postorder(node.right_node, result_array, &block) unless node.right_node.nil?
    result_array << node.value
    yield(node.value) if block_given?
    result_array
  end

  def level_order_rec(array = [@root.value], result_array = [], &block)
    value = array[0]
    yield(value) if block_given?
    array.slice!(0)
    node = find(value)
    result_array << value
    array << node.left_node.value unless node.left_node.nil?
    array << node.right_node.value unless node.right_node.nil?
    level_order_rec(array, result_array, &block) unless array.empty?

    result_array
  end

  def level_order_iter(array = [@root], result_array = [])
    while array.empty? == false
      array << array[0].left_node unless array[0].left_node.nil?
      array << array[0].right_node unless array[0].right_node.nil?
      if block_given?
        yield(array[0].value)
      else
        result_array << array[0].value
      end
      array.slice!(0)
    end
    result_array
  end

  def find(value, node = @root)
    if value < node.value
      find(value, node.left_node)
    elsif value > node.value
      find(value, node.right_node)
    elsif value = node.value
      node
    end
  end

  def delete(value, node = @root)
    if value < node.value
      if value == node.left_node.value
        if node.left_node.left_node.nil? && node.left_node.right_node.nil?
          node.left_node = nil
        elsif node.left_node.left_node.nil?
          node.left_node = node.left_node.right_node
        elsif node.left_node.right_node.nil?
          node.left_node = node.left_node.left_node
        else
          node.left_node.value = min_higher(value, node.left_node.right_node).value
        end
      else
        delete(value, node.left_node)
      end
    elsif value > node.value
      if node.right_node.left_node.nil? && node.right_node.right_node.nil?
        node.right_node = nil
      elsif node.right_node.left_node.nil?
        node.right_node = node.right_node.right_node
      elsif node.left_node.right_node.nil?
        node.right_node = node.right_node.left_node
      else
        node.right_node.value = min_higher(value, node.right_node.right_node).value
      end
    else
      delete(value, node.left_node)
    end
  end

  def min_higher(value, node)
    if node.left_node.left_node.nil?
      n_node = node.left_node
      node.left_node = nil
      n_node
    else
      min_higher(value, node.left_node)
    end
  end

  def insert(value, node = @root)
    if value < node.value
      if node.left_node.nil?
        node.left_node = Node.new(value)
      else
        insert(value, node.left_node)
      end
    elsif value > node.value
      if node.right_node.nil?
        node.right_node = Node.new(value)
      else
        insert(value, node.right_node)
      end
    elsif value == node.value
      puts 'This value has already been added'
    end
  end

  def build_tree(array)
    if array.length < 2
      Node.new(array[0]) unless array[0].nil?
    else
      mid = array.length / 2
      root = array[mid]
      left_node = build_tree(array[0..mid - 1])
      right_node = build_tree(array[mid + 1...array.length])
      Node.new(root, right_node, left_node)
    end
  end

  def merge_sort(array)
    if array.length < 2
      array
    else
      mid = array.length / 2
      left_array = merge_sort(array[0..mid - 1])
      right_array = merge_sort(array[mid..array.length - 1])
      merge(left_array, right_array)
    end
  end

  def merge(left_array, right_array)
    sorted_array = []
    while left_array.length > 0 && right_array.length > 0
      if left_array[0] == right_array[0]
        left_array.slice!(0)
      else
        sorted_array << if left_array[0] > right_array[0]
                          right_array.slice!(0)
                        else
                          left_array.slice!(0)
                        end
      end
    end

    sorted_array << left_array.slice!(0) while left_array.length > 0
    sorted_array << right_array.slice!(0) while right_array.length > 0
    sorted_array
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

  class Node
    attr_accessor :value, :right_node, :left_node

    def initialize(value, right_node = nil, left_node = nil)
      @value = value
      @right_node = right_node
      @left_node = left_node
    end
  end
end

A = Tree.new(Array.new(15) {rand(1...100)})
A.pretty_print
print A.balance?
print "\n"
print A.level_order_iter
print "\n"
print A.preorder
print "\n"
print A.postorder
print "\n"
print A.inorder
print "\n"
A.insert(100)
A.insert(104)
A.insert(105)
A.insert(200)
A.pretty_print
print A.balance?
A.rebalance
print "\n"
print A.balance?
A.pretty_print

