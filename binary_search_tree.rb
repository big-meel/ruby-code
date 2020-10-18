require 'byebug'
class Node
  attr_reader :data
  attr_accessor :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child
    @right_child
  end
  # Returns true if root has no children
  def is_a_leaf?
    self.left_child.nil? && self.right_child.nil?
  end

  # Returns single child of node, nil if node has more than one or none
  def has_one_child
    if self.left_child.nil? && !self.right_child.nil?
      self.right_child
    elsif !self.left_child.nil? && self.right_child.nil?
      self.left_child
    else
      nil
    end
  end

  def inorder_successor
    
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
  def insert( data, node = @root, prev_node =  nil, child = "" ) 
    return prev_node.right_child = Node.new( data ) if node.nil? && child == 'right'
    return prev_node.left_child = Node.new( data ) if node.nil? && child == 'left'
      
    if node.data == data
      return node
    elsif data > node.data
      insert(data, node.right_child, prev_node = node, child = 'right')
    elsif data < node.data
      insert(data, node.left_child, prev_node = node, child = 'left')
    end    
  end

  # Finds the left most leaf in given node
  def minimum_value( node )
    current = node

    while current.left_child != nil do
      current = current.left_child
    end

    return current
  end

  # If node to be deleted is a leaf, simply remove it from the tree
  # If node to be deleted has one child, copy child to the node and delete child
  # If node to be deleted has two children, Find Inorder successor (next node in line
  # eg. 6 comes after 5) copy successor contents to node and delete the successor
  def delete( key, node = root, prev_node = nil, child = Proc.new {})
    if node.data == key
      if node.is_a_leaf? 
        return child.call(prev_node, nil)
      elsif node.has_one_child
        return child.call(prev_node, node.has_one_child)
      else
        
      end
    end 
    
    # Use Procs to identify which child is being affected
    if key < node.data
      left = Proc.new {|node, new_node| node.left_child = new_node}
      delete(key, node.left_child, node, left)
    elsif key > node.data
      right = Proc.new {|node, new_node| node.right_child = new_node}
      delete(key, node.right_child, node, right)
    end
  end

  def find( key, node = root )
    return nil if node.nil?
    return node if node.data == key

    if key > node.data
      find( key, node.right_child )
    elsif key < node.data
      find( key, node.left_child )
    end
  end

  # Method to return tree in a readable output
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

  # test_array1 = [1,2,3,4,5,6,7,8]
  # test_array2 = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

  # tree = Tree.new(test_array1)
  # # puts tree.root.data
  # # puts tree.root.left_child.left_child.data
  # x = tree.root.left_child.left_child
  # x.left_child = Node.new(0)
  # puts tree.pretty_print
  # tree.delete(0)
  # puts tree.pretty_print
  # tree.delete(1)
  # puts tree.pretty_print
  # tree.delete(7)
  # puts tree.pretty_print
  # puts tree.root.right_child.right_child.has_one_child.data
  # tree.insert( 9 )
  # tree.insert( 0 )
  # tree.pretty_print
  # puts tree.minimum_value( tree.root ).data
  # tree.pretty_print
  # puts tree.find(3)
  # puts tree.delete(0)
  # tree.pretty_print
  

  

  
  # tree.root.left_child.left_child.left_child = Node.new(0)
  # puts tree.root.left_child.left_child.left_child.data