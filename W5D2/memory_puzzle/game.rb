require_relative "board.rb"
require_relative "player.rb"
require_relative "card.rb"

class Game
    
    attr_accessor :players, :board, :name1, :name2

    def initialize(name1, name2)
        @players = [Player.new(name1), Player.new(name2)]
        @board = Board.new()
        @name1 = name1
        @name2 = name2
    end
    
    def current_player
        @players.first
    end

    def switch_players!
        @players.rotate!
    end

    def count_score
        
        
    end

    def play_turn
        counter = 0
        saved_positions = []
        while counter != 2
            lolz = false
            while lolz == false
                puts "Enter a position on the grid to guess (1-4) ie: (1 2)"
                pos = gets.chomp.split.map { |ele| ele.to_i }
                if (pos[0].to_i < 1 || pos[0].to_i > 4) && (pos[1].to_i < 1 || pos[1].to_i > 4)
                    puts "Try again, fool"
                    next
                end
                lolz = true
            end

            
            # begin
            # puts "Enter a position on the grid to guess (1-4) ie: (1 2)"
            # pos = gets.chomp.split
            #     raise if pos[0] < 1 || pos[0] > 4
            #     raise if pos[1] < 1 || pos[1] > 4
            # rescue 
            #     puts "Try again, fool"
            #     retry
            # end
            # debugger
            @board[pos].face_up = true
            saved_positions << pos
            @board.render
            counter += 1
            # debugger
            if counter == 2
                if @board[saved_positions[0]].value != @board[saved_positions[1]].value
                    @board[saved_positions[0]].hide
                    @board[saved_positions[1]].hide
                else
                    current_player.score += 1
                end
                @board.render
            end
        end
    
    end 
    #    def play_turn
    #     if current_player.name == name
    #         @board.render
    #     end

    #     begin
    #         current_player.get_move(current_player.mark, @board)
    #     rescue RuntimeError
    #         puts 'Enter a valid position'
    #         retry
    #     end
        
    #     current_player.mark
    # end


    def play
        @board.populate
        until game_over?
            play_turn
            switch_players!
        end
        puts "#{current_player.name} wins!"
    end

    def game_over?
        @players.each do |player|
            if player.score == 8
                return true
            end
        end
        false
    end
end

if __FILE__ == $PROGRAM_NAME
    g  = Game.new("A","B")
    g.play
end

