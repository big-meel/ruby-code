require '../binary_search_tree.rb'

describe Tree do
  subject {Tree.new([1,2,3,4,5,6,7,8])}
  
  describe '#pretty_print' do
    it "prints tree in readable representation" do
      expect(subject.pretty_print)
    end
  end

  describe '#root' do
    it 'returns minimum value' do
      expect(subject.root.minimum_value).to eq 1
    end

    it 'returns minimum value of current node' do
      expect(subject.root.right_child.minimum_value).to eq 5
    end
  end
  
  describe '.delete' do
    context 'when node is a leaf' do
      it 'removes a single node' do
        subject.delete(1)
        expect(subject.root.left_child.left_child).to eq nil
      end
    end
    
    context 'when node has one child' do
      it 'removes node' do
        node_to_remove = subject.root.right_child.right_child
        subject.delete(7)
        expect(subject.root.right_child.right_child.data).not_to eq node_to_remove.data
      end

      it 'copies child to the node' do
        node_to_copy = subject.root.right_child.right_child.right_child
        subject.delete(7)
        expect(subject.root.right_child.right_child.data).to eq node_to_copy.data
      end
    end

    context 'when node has 2 children' do
      it 'removes node' do
        node_to_remove = subject.root
        subject.delete(4)
        expect(subject.root.data).not_to eq node_to_remove.data
      end

      it 'finds inorder successor' do
        expect(subject.inorder_successor).to eq 5
      end

      it 'copies inorder successor to node' do
        successor = subject.inorder_successor(4)
        subject.delete(4)
        expect(subject.root).to eq successor
      end
    end
  end

end