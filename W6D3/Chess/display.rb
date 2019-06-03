require 'colorize'
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
                if @cursor.cursor_pos == [r, c]
                    print "🐓 "
                elsif board[[r, c]].is_a?(NullPiece)
                    print "_ "
                else
                    print"♟ "
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
            @cursor.get_input
            system "clear"
        end
    end



end


b = Board.new
d = Display.new(b)
d.play_game