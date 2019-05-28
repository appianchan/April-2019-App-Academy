class Minesweeper
    def initialize(n = 9)
        @n = n
        @grid = Array.new(n) {Array.new(n, :s)}
    end

    def play
        render
        place_bombs
        render
    end

    def reveal
        a;lskdjfasd;lfkj
    end

    def place_bombs
       
        5.times do 
            @grid[rand(0...@grid.length)][rand(0...@grid.length)] = "*"
        end
    end


    def render
        puts "\s\s#{(0...@grid.length).to_a.join(" ")}"
        @grid.each.with_index do |row, idx|
            print "#{idx} #{row.join(" ")}"
            puts
        end
    end

    def user_input()
    end
end

Minesweeper.new.play