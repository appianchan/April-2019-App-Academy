require_relative "Stepable"
class Knight < Piece
    include Stepable
    def initialize(color, board, pos)
        super
    end

    def symbol
        return '♘' if color == :black
        return '♞' if color == :white
    end

    def move_diffs
        [[1, 2], [2, 1], [1, -2], [2, -1], [-1, 2], [-2, 1], [-2, -1], [-1, -2]]
    end

    
    
end