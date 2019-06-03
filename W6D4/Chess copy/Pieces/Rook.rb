require_relative "Slideable"

class Rook < Piece

    include Slideable
    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def symbol
        return '♖' if color == :black
        return '♜' if color == :white
    end
    
    def move_dirs
        [[0, 1], [0, -1], [1, 0], [-1, 0]]
    end

    
    
    
end