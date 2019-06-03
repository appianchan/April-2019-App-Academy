require_relative './Pieces/piece.rb'
require_relative './Pieces/Rook.rb'
require_relative './Pieces/Knight.rb'
require_relative './Pieces/Bishop.rb'
require_relative './Pieces/Queen.rb'
require_relative './Pieces/King.rb'
require_relative './Pieces/Pawn.rb'
require_relative './Pieces/null_piece.rb'

class Board

    attr_reader :board

    def initialize
        @board = Array.new(8){Array.new(8)}
        @board = @board.map.each_with_index do |row, r|
            row.map.each_with_index do |col, c|
                if r == 1
                    col = Pawn.new(:white, self, [r, c])
                elsif r == 6
                    col = Pawn.new(:black, self, [r, c])
                elsif r == 0 && (c == 0 || c == 7)
                    col = Rook.new(:white, self, [r, c])
                elsif r == 7 && (c == 0 || c == 7)
                    col = Rook.new(:black, self, [r, c])

                elsif r == 0 && (c == 1 || c == 6)
                    col = Knight.new(:white, self, [r, c])
                elsif r == 7 && (c == 1 || c == 6)
                    col = Knight.new(:black, self, [r, c])


                elsif r == 0 && (c == 2 || c == 5)
                    col = Bishop.new(:white, self, [r, c])
                elsif r == 7 && (c == 2 || c == 5)
                    col = Bishop.new(:black, self, [r, c])

                elsif r == 0 && c == 3
                    col = King.new(:white, self, [r, c])
                elsif r == 7 && c == 3
                    col = King.new(:black, self, [r, c])

                elsif r == 0 && c == 4
                    col = Queen.new(:white, self, [r, c])
                elsif r == 7 && c == 4
                    col = Queen.new(:black, self, [r, c])
            

                
                # if idx == 0 || idx == 1 || idx == 6 || idx == 7
                #     col = Piece.new()
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
            return nil
        # elsif !self[end_pos].is_a?(NullPiece)
        #     raise "You can't move there"
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

    def move_piecee(color, start_pos, end_pos)
        if self[start_pos].moves(start_pos).include?(end_pos)
            if move_piece(start_pos, end_pos) == nil
                capture(board[start_pos].color, start_pos, end_pos)
            end
        end

    end

    def capture(color, start_pos, end_pos)
        if color == :black 
            if self[end_pos].color == white
                self[end_pos] = self[start_pos]
                self[start_pos] = NullPiece.new()
            end
        else
            if self[end_pos].color == black
                self[end_pos] = self[start_pos]
                self[start_pos] = NullPiece.new()
            end
        end
    end
end