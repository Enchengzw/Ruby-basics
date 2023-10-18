class LinkedList
  @@count = 0
  attr_reader :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def append(value)
    node = Node.new(value)
    @@count += 1
    if @@count == 1
      @head = node
    elsif @@count == 2
      @head.next_node = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def prepend(value)
    node = Node.new(value)
    @@count += 1
    if @@count == 1
      @head = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def size
    @@count
  end

  def at(index, i = 1, node = @head)
    if i == index
      node.value
    else
      i += 1
      at(index, i, node.next_node)
    end
  end

  def pop(node = @head)
    if node.next_node.next_node.nil?
      node.next_node = nil
      @tail = node
    else
      pop(node.next_node)
    end
  end

  def contains?(value, node = @head)
    if node.nil?
      false
    elsif node.value == value
      true
    else
      contains?(value, node.next_node)
    end
  end

  def find(value, node = @head, index = 1)
    if node.nil?
      return false
    elsif node.value == value
      return index
    else
      index += 1
      find(value, node.next_node,index)
    end
  end

  def to_s(node = @head, string ="")
    if node.nil?
      string += "nil"
      return string
    else
      string += "( #{node.value} ) -> "
      to_s(node.next_node, string)
    end
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

L = LinkedList.new
L.append(1)
L.append(2)
L.append(6)
puts L.to_s

