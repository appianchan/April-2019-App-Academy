require_relative '00_tree_node.rb'

class KnightPathFinder


    attr_reader :root_node, :considered_positions, :start_pos

    def self.valid_moves(pos)
        # final = []
        x,y = pos
        offset = [[x-2,y-1], [x-2, y+1], [x-1, y-2], [x-1, y+2], [x+1, y-2], [x+1, y+2], [x+2, y-1], [x+2, y+1]]
        offset.select { |pos| pos[0].between?(0,7) &&  pos[1].between?(0,7) }
# rip
#  can i get terminal access rq

        # if (x+2 < 8 && x+2 >= 0) &&  (y+1 < 8 && y + 1 >=0)
        #     final << [x+2, y+1]
        # end
        # if (x+2 < 8 && x+2 >= 0) &&  (y-1 < 8 && y - 1 >=0)
        #     final << [x+2, y-1]
        # end
        # if (x-2 < 8 && x-2 >= 0) &&  (y+1 < 8 && y + 1 >=0)
        #     final << [x-2, y+1]
        # end
        # if (x-2 < 8 && x-2 >= 0) &&  (y-1 < 8 && y - 1 >=0)
        #     final << [x-2, y-1]
        # end
        # if (x+1 < 8 && x+1 >= 0) &&  (y+2 < 8 && y + 2 >=0)
        #     final << [x+1, y+2]
        # end
        # if (x+1 < 8 && x+1 >= 0) &&  (y-2 < 8 && y -2 >=0)
        #     final << [x+1, y-2]
        # end
        # if (x-1 < 8 && x-1 >= 0) &&  (y+2 < 8 && y + 2 >=0)
        #     final << [x-1, y+2]
        # end
        # if (x-1 < 8 && x-1 >= 0) &&  (y-2 < 8 && y - 2 >=0)
        #     final << [x-1, y-2]
        # end
        # final
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
    

# [3,3]

# [1,2]
# [1,4]
# [2,1]
# [2,5]
# [4,1]

# [4,5]
# [5,2]
# [5,4]

]

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

    def build_move_tree(root_node)
        arr = new_move_positions(root_node.value) # 
        arr.each do |el|
            second_node = PolyTreeNode.new(el)
            root_node.add_child(second_node)
        end
        queue = root_node.children
        until queue.empty?
            arr = new_move_positions(queue[0].value)

            #add node as child to queue[0]
            arr.each do |el|
                second_node = PolyTreeNode.new(el)
                queue[0].add_child(second_node)
            end

            queue += queue.shift.children
                
        end

    end



    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        moves = moves.reject { |move| @considered_positions.include?(move) }
        @considered_positions += moves
        moves
    end


    def inspect
        puts "this is the new inspect"

    end
end


