require_relative "Slideable"
class Queen < Piece
    include Slideable
    def initialize(color, board, pos)
        super
    end

    def symbol
        return '♕' if color == :black
        return '♛' if color == :white
    end
    
    def move_dirs
        [[1, 1], [-1, -1], [1, -1], [-1, 1], [0, 1], [0, -1], [1, 0], [-1, 0]]
    end
    
    
    
end