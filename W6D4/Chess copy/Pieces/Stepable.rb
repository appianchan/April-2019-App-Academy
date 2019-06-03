module Stepable
attr_accessor :color, :pos, :board
    def moves(pos)
        final = []
        move_diffs.each do |move| # [1, 2]
            dx, dy = move #[1, 2]
            x, y = pos # [2, 2]
            new_position = [dx + x, dy + y] # [3, 4]

            if board.valid_pos?(new_position) && 
                (board[new_position].is_a?(NullPiece) || 
                    (!board[new_position].is_a?(NullPiece) && board[new_position].color != board[pos].color))
                
                
                final << new_position
                # dx, dy = move #[0, 1]
            end

        end

        final
    end
    
    
    
end