require_relative "Stepable"
class King < Piece
    include Stepable
    def initialize(color, board, pos)
        super
    end

    def symbol
        return '♔' if color == :black
        return '♚' if color == :white
    end
    
    def move_diffs
        [[1, 1], [-1, -1], [1, -1], [-1, 1], [0, 1], [0, -1], [1, 0], [-1, 0]]
    end
    
    
    
end