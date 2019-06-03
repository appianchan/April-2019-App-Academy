require 'colorize'
require 'colorized_string'
require_relative 'cursor.rb'
require_relative 'board.rb'

class Display
    attr_reader :board
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
        
    end

    def render
        
        @board.board.each_with_index do |row, r|
            row.each_with_index do |col, c|
                if board[[r, c]].is_a?(NullPiece)
                    if @cursor.cursor_pos == [r, c]
                        print"_ ".colorize(:background => :light_green)
                    else 
                        print "_ "
                    end
                else
                    if @cursor.cursor_pos == [r, c]
                        print "#{col.symbol} ".colorize(:background => :light_green)
                    else 
                        print"#{col.symbol} "
                    end
                end


                if c == 7
                    puts ""
                end
            end
        end

    end 

    def play_game
        system "clear"
        loop do
            self.render
            if @cursor.get_input == 'selected piece'
                start_pos = @cursor.cursor_pos
                loop do
                    system "clear"
                    self.render
                    if @cursor.get_input == 'selected piece'
                        end_pos = @cursor.cursor_pos
                        @board.move_piecee(:white, start_pos, end_pos)
                        break
                    end
                    
                end
            end
            system "clear"
        end
    end



end


b = Board.new
d = Display.new(b)
d.play_game