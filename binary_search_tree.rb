require 'byebug'
class Node
  attr_reader :data
  attr_accessor :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child
    @right_child
  end
end


class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

    # Recursive Method; begin with first and last defined with default values
    def build_tree( arr, first_index = 0, last_index = arr.length - 1 )
      return nil if first_index > last_index

    middle_of_array = (first_index + last_index)/2

    root = Node.new(arr[middle_of_array])

    root.left_child = build_tree(arr, first_index, middle_of_array - 1)
    root.right_child = build_tree(arr, middle_of_array + 1, last_index)

    return root 
  end

  # Insert Method: prev_node and child added so the writer methods left_child and right_child can be utilized
  def insert(data, node = @root, prev_node =  nil, child = "")
    return prev_node.right_child = Node.new(data) if node.nil? && child == 'right'
    return prev_node.left_child = Node.new(data) if node.nil? && child == 'left'
      
    if node.data == data
      return node
    elsif data > node.data
      insert(data, node.right_child, prev_node = node, child = 'right')
    elsif data < node.data
      insert(data, node.left_child, prev_node = node, child = 'left')
    end    
  end

  # :delete method

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end

  test_array1 = [1,2,3,4,5,6,7,8]
  test_array2 = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

  tree = Tree.new(test_array1)
  puts tree.root.data
  puts tree.root.left_child.left_child.data
  x = tree.root.left_child.left_child.left_child
  tree.insert(9)
  tree.insert(0)
  tree.pretty_print

  
  # tree.root.left_child.left_child.left_child = Node.new(0)
  # puts tree.root.left_child.left_child.left_child.data