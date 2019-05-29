require_relative "piece.rb"
require_relative "null_piece.rb"

class Board

    attr_reader :board

    def initialize
        @board = Array.new(8){Array.new(8)}
        @board = @board.map.each_with_index do |row, idx|
            row.map do |col|
                if idx == 0 || idx == 1 || idx == 6 || idx == 7
                    col = Piece.new()
                else
                    col = NullPiece.new()
                end
            end
        end
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos,value)
        row, col = pos
        @board[row][col] = value
    end

    def move_piece(start_pos, end_pos)
        if self[start_pos].is_a?(NullPiece)
            raise "No piece at start position"
        elsif !self[end_pos].is_a?(NullPiece)
            raise "You can't move there"
        end

        self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    end

    def valid_pos?(pos)
        x, y = pos
        if x >= 0 && x <= 7 && y >= 0 && y <= 7
            return true
        end
        false
    end
end