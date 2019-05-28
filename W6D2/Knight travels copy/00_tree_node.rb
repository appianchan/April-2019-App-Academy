require 'byebug'
class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        # debugger
        self.parent.children.delete(self) if parent != nil
        #just in case you come back early to try it, i fixed it with the code above. Our line of reasoning worked,
        #but we needed to add parent != nil for the case when are parent actually exists. the rspec screwed us over
        
        #  lol yeah, i actually typed something very similar to that exact line of code i think, 
        # but then i was like well if parent is nil, nevermind and deleted it because i thought i was being dumb
        # shoulda just moved it to the top



        @parent = node
        return nil if self.parent == nil
        node.children << self if !node.children.include?(self)
        # debugger
        # node.children.delete(self.children)
        # node.children.pop
        # self.parent.children.pop
        
    end

    def add_child(node)
        @children << node
        node.parent = self 
    end

    def remove_child(node)
        if @children.include?(node)
            @children.delete(node)
            node.parent = nil
        else
            raise 'node is not a child'
        end
    end

    def dfs(target_value)
        return self if self.value == target_value
        
        self.children.each do |child|
            searched = child.dfs(target_value)
            return searched if searched != nil
        end

        return nil
    end

    def bfs(target_value)
        return self if self.value == target_value
        queue = self.children
        until queue.empty?
            if queue.first.value == target_value
                return queue.first
            else
                first_node = queue.shift
                queue += first_node.children
            end
        end
        return nil
    end
end



# node1 = PolyTreeNode.new('root')
# node2 = PolyTreeNode.new('child1')
# node3 = PolyTreeNode.new('child2')


#    root
#    / \
#  c1   c2


# node1 = PolyTreeNode.new('root')
# node2 = PolyTreeNode.new('child1')
# node3 = PolyTreeNode.new('child2')

# node2.parent = node1
# node3.parent = node1 

# describe "#parent=" do
#     before do
#       node2.parent = node1 #node1@children = [node2] / node2@parent = node1
#       node3.parent = node1 #node1@children = [node2, node3] / node3@parent = node1
#     end

#     it "should set a node's parent to the passed node" do
#       expect(node2.parent).to equal(node1)
#       expect(node3.parent).to equal(node1)
#     end

#     it "should add the child node to the passed node's children" do
#       expect(node1.children).to eq([node2, node3])
#     end

#     it "does not add the same node twice" do
#       node3.parent = node1
#       expect(node1.children).to eq([node2, node3])
#     end

#     it "handles nil without issue" do
#       node2.parent = nil
#       expect(node2.parent).to be_nil
#     end

#     context "when reassigning" do
#       before { node3.parent = node2 }

#       it "should set the node's parent to the new parent" do
#         expect(node3.parent).to equal(node2)
#       end

#       it "should add the node to the new parent's children" do
#         expect(node2.children).to include(node3)
#       end

#       it "should remove the node from its old parent's children" do
#         expect(node1.children).to_not include(node3)

#       end
#     end
#   end
