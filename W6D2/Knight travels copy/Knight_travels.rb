require_relative '00_tree_node.rb'
require 'byebug'
class KnightPathFinder


    attr_reader :root_node, :considered_positions, :start_pos

    def self.valid_moves(pos)
        x,y = pos
        offset = [[x-2,y-1], [x-2, y+1], [x-1, y-2], [x-1, y+2], [x+1, y-2], [x+1, y+2], [x+2, y-1], [x+2, y+1]]
        offset.select { |pos| pos[0].between?(0,7) &&  pos[1].between?(0,7) }
    end 

    # valid_moves of [3, 3] are [[1,2],[2,1],[4,1],[5,2],[5,4],[4,5],[2,5],[1,4]]
    
    # start at [0,0] valid_moves are [[1,2][2,1]]
    # @considered_positions =
    # check if [1,2] is target_pos, if not, check if [2,1] is target_pos
    # if not 
    # cant move back to [0,0] because we came from there
    # pos is [1,2] valid_moves are [[0,4], [1,2], [2,0], [2,4], [3,1], [3,3]]

    # kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]

    # x, y = pos
    

    # [
    #     [0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6],[0,7],

    #     [1,0],[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],

    #     [2,0],[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],

    #     [3,0],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],

    #     [4,0],[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],[4,7],

    #     [5,0],[5,1],[5,2],[5,3],[5,4],[5,5],[5,6],[5,7],

    #     [6,0],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7],

    #     [7,0],[7,1],[7,2],[7,3],[7,4],[7,5],[7,6],[7,7]
    # ]

    def initialize(start_pos)
        @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree(root_node)
    end

    # [0,0] => valid [1,2] [2,1]
    # queue [[0,0]]
    # that's not the value
    # queue [[1,2] [2,1], ... ]  
    # [3,3]
    # path [[3,3]]
    # parent of [3,3] => [2,1]
    # path [[2,1], [3,3]]
    # path [[0,0], [2,1], [3,3]]

    def find_path(end_pos)
        path = []
        queue = [@root_node]
        until queue.empty?
            # debugger
            if end_pos == queue.first.value
                path = [queue.first]
                until path.first.value == @start_pos
                    path.unshift(path.first.parent)
                end
                return path.map { |node| node.value }
            end
            queue.shift.children.each { |node| queue << node }
        end
        nil
    end


    # def build_move_tree(root_node)
    #     arr = new_move_positions(root_node.value) # 
    #     arr.each do |el|
    #         second_node = PolyTreeNode.new(el)
    #         root_node.add_child(second_node)
    #     end
    #     # debugger
    #     queue = root_node.children
    #     until queue.empty?
    #         arr = new_move_positions(queue[0].value)

    #         #add node as child to queue[0]
    #         arr.each do |el|
    #             second_node = PolyTreeNode.new(el)
    #             queue[0].add_child(second_node)
    #         end

    #         queue += queue.shift.children
                
    #     end

    # end

    def build_move_tree(root_node)
        queue = [root_node]
        until queue.empty?
            new_move_positions(queue.first.value).each do |pos|
                child_node = PolyTreeNode.new(pos)
                queue.first.add_child(child_node)
                queue << child_node
            end
            queue.shift
        end 
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        moves = moves.reject { |move| @considered_positions.include?(move) }
        @considered_positions += moves
        moves
    end

    

    # def inspect
    #     puts "this is the new inspect"

    # end
end

# p KnightPathFinder.new([0,0]).find_path([3,3])
# KnightPathFinder.new([3,3])#.build_move_tree(PolyTreeNode.new([0,0]))


# queue = [root_node]
    # until queue.empty?
        # new_move_positions(queue.first.value).each do |pos|
            # queue.first.children << PolyTreeNode.new(pos)
        # end
        # queue.shift
    # end