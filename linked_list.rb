# As for this project I wanted to do as many recursions as possible; 
# several of these methods will have default values in assumption
# the user will only provide arguments requested.
# A later revision will have these methods refactored with helper methods to
# to better convey the requested behaviour.

class LinkedList
  class Node
    attr_accessor :next_node, :value

    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end      
  end

  def initialize(node = Node.new)
    @node = node
  end

  def head
    @node
  end

  def tail(node = self.head)
    return node if node.next_node.nil?
    tail(node.next_node)
  end

  def append(value)
    unless self.head.value.nil?      
       return self.tail.next_node = Node.new(value) if self.tail.next_node.nil?
    else
      @node = Node.new(value)
    end
  end

  def prepend(value)
    if self.head.value.nil?
      @node = Node.new(value)
    else
      @node = Node.new(value, head)
    end
  end

  def pop(node = head)
    if node.next_node == self.tail
      puts tail.value
      return node.next_node = nil
    end
    pop(node.next_node)
  end

  def size(count = 0, node = head)
    return count if node.nil?
    count += 1
    size(count, node.next_node)
  end

  def at(index, node = head, count = 0)
    return node if count == index
    count += 1 
    at(index, node.next_node, count)
  end

  def contains?(value, node = head)
    if node.value == value
      return true
    elsif node.next_node.nil?
      return false
    end
    contains?(value, node.next_node)
  end

  def find(value, node = head, marker = 0)
    return nil unless self.contains?(value)
    return marker if node.value == value
    find(value, node.next_node, marker += 1)
  end

  def to_s(node = head, output = "")
    output += " ( #{node.value} ) ->"
    return output + " nil" if node.next_node.nil?
    to_s(node.next_node, output )
  end

  # Extra Credit

  def insert_at(value, index)
    shifting_node = self.at(index)
    unless shifting_node == self.head
      previous_node = self.at(index-1)
      previous_node.next_node = Node.new(value, shifting_node)
    else
      prepend(value)
    end
  end

  def remove_at(index)
    leaving_node = self.at(index)
    unless leaving_node == self.head
      self.at(index-1).next_node = leaving_node.next_node if index < self.size
    else
      @node = leaving_node.next_node
    end
  end
end



list = LinkedList.new
list.append('H')
list.prepend('Q')
list.append('Z')
list.append('J')
puts list
puts list.size
puts list.at(1).value
list.pop
puts list.size
puts list.contains?('Z')
puts list.find('Z')
puts list.find('H')
puts list
list.insert_at('G', 2)
puts list
list.remove_at(2)
list.remove_at(0)
puts list

# They all work :)