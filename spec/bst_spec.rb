require '../binary_search_tree.rb'

describe Tree do
  subject {Tree.new([1,2,3,4,5,6,7,8])}
  
  describe '#pretty_print' do
    it "prints tree in readable representation" do
      expect(subject.pretty_print)
    end
  end
  
  describe '.delete' do
    context 'when node is a leaf' do
      it 'remove a single node' do
        subject.delete(1)
        expect(subject.root.left_child.left_child).to eq nil
      end
    end
    
    context 'when node has one child' do
      it 'remove node' do
        node_to_remove = subject.root.right_child.right_child
        subject.delete(7)
        expect(subject.root.right_child.right_child.data).not_to eq node_to_remove.data
      end

      it 'copy child to the node' do
  
      end
    end
  end

end