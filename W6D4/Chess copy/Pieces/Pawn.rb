require_relative 'Piece.rb'

class Pawn < Piece
    attr_accessor :color, :board, :pos

    def initialize(color, board, pos)
        super
    end

    def symbol
        return '♙' if color == :black
        return '♟' if color == :white
    end
    
    def move_dirs
        if forward_dir == -1
            return [[1, 0], [1,1], [1,-1]]
        else
            return [[-1, 0], [-1,-1], [-1, 1]]
        end      
    end

    def moves(pos)
        sidess = side_attacks
        x,y = pos
        case forward_dir

        when 1
            sidess << [x-1, y+0] if board[[x-1,y+0]].is_a?(NullPiece) && board.valid_pos?([x-1,y+0])
        when -1
            sidess << [x+1, y+0] if board[[x+1,y+0]].is_a?(NullPiece) && board.valid_pos?([x+1,y+0])
        end
        sidess
        
        
    end
    

    private

    def forward_dir
        #black is on the bottom
        color == :black ? 1 : -1
    end

    def side_attacks
        final = []
        x,y = pos
        case color

        when :white
            if !board[[x + 1, y + 1]].is_a?(NullPiece) && board[[x + 1, y + 1]].color == :black && board.valid_pos?([x + 1, y + 1])
                final << [x + 1, y + 1]
            elsif !board[[x + 1, y - 1]].is_a?(NullPiece) && board[[x + 1, y - 1]].color == :white && board.valid_pos?([x + 1, y - 1])
                final << [x + 1, y - 1]
            end
        when :black
            if !board[[x - 1, y - 1]].is_a?(NullPiece) && board[[x - 1, y - 1]].color == :white && board.valid_pos?([x - 1, y - 1])
                final << [x - 1, y - 1]
            elsif !board[[x - 1, y + 1]].is_a?(NullPiece) && board[[x - 1, y + 1]].color == :white && board.valid_pos?([x - 1, y + 1])
                final << [x - 1, y + 1]
            end
        end
        final
        
    end
    
end