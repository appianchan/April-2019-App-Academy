module Slideable

    attr_accessor :color, :pos, :board
    def moves(pos)
        final = []
        move_dirs.each do |move|
            dx, dy = move #[1, 1]
            x, y = pos # [2, 2]
            new_position = [dx + x, dy + y] # [3, 3]

            if board[pos].color == :white
                until !board.valid_pos?(new_position) || (!board[new_position].is_a?(NullPiece) && board[new_position].color == :white)
                    if !board[new_position].is_a?(NullPiece) && board[new_position].color == :black 
                        final << new_position
                    # dx, dy = move #[0, 1]
                        x, y = new_position # [3, 3]
                        new_position = [dx + x, dy + y] # [4, 4]
                    break
                    end
                    final << new_position
                    # dx, dy = move #[0, 1]
                    x, y = new_position # [3, 3]
                    new_position = [dx + x, dy + y] # [4, 4]
                end
            elsif board[pos].color == :black
                until !board.valid_pos?(new_position) || (!board[new_position].is_a?(NullPiece) &&board[new_position].color == :black)
                    # line 10 works if not capturing a piece
                    final << new_position
                    # dx, dy = move #[0, 1]
                    x, y = new_position # [3, 3]
                    new_position = [dx + x, dy + y] # [4, 4]
                end
            end

        end

        final
    end
    
    
end