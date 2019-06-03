class Piece
    attr_accessor :color, :pos, :board

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end


end