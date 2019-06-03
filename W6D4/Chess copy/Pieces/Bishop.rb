require_relative "Slideable"
class Bishop < Piece
    include Slideable
    def initialize(color, board, pos)
        super
    end

    def symbol
        return '♗' if color == :black
        return '♝' if color == :white
    end
    
    def move_dirs
        [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    end
    
end