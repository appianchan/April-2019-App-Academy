require_relative 'card.rb'
require 'byebug'
class Board

    attr_reader :grid

    def initialize
        @grid = Array.new(5) {Array.new(5, "")}
    end

    def populate
        alpha = ('A'...'Z').to_a
        shuffled = []
        temp = []
        8.times do 
            c = Card.random_card
            shuffled << c
            temp << c.value
        end
    
        temp = temp.uniq

        while temp.length != 8
            letter = alpha.sample
            temp << letter
            temp = temp.uniq
        end

        stack2 = []
        8.times do 
            c = Card.random_card
            stack2 << c
        end

        i = 0
        while i < 8
            card = shuffled[i]
            card.value = temp[i]
            i += 1
        end

        i = 0
        while i < 8
            card = stack2[i]
            card.value = temp[i]
            i += 1
        end

        shuffled = stack2 + shuffled
        shuffled = shuffled.shuffle
        # p shuffled
        

        # shuffled = temp

        # shuffled2 = shuffled.clone
        # shuffled = shuffled2 + shuffled
        # shuffled = shuffled.shuffle
        # # shuffled.dup.shuffle
        # # [8 random cards, dup = > 16].shuffle
        # # cards = []
        # # 8.times do 
        # #     cards << Card.random_card
        # end
        # cards_2 = cards.dup
        # cards_2 + cards
        # p shuffled

        (1..4).each do |row|
            (1..4).each do |col|
                card = shuffled.shift
                pos = [row,col]
                self[pos] = card
            end
        end
        
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end
    
    def []=(pos, value)
        row, col = pos
        @grid[row][col] = value
    end
        

    def render
        # debugger
        print self[[0,0]] = ' '
        print self[[0,1]] = 0
        print self[[0,2]] = 1
        print self[[0,3]] = 2
        puts self[[0,4]] = 3
        # print self[[1,0]] = 0
        # print self[[2,0]] = 1
        # print self[[3,0]] = 2
        # print self[[4,0]] = 3
        counter = 0
        (1..4).each do |row|
           (0..4).each do |col|
                pos = [row, col]
                if col == 0
                    self[pos] = counter
                    print "#{counter}"
                    counter += 1
                    next
                end
                
                card = self[pos]
                if card.face_up == true
                    print "#{card.to_s}"
                else
                    print " "
                end
                if col == 4
                    puts ""
                end
            end
        end
    end

    def won?(card1, card2)
        if card1 == card2
            return true
        end
        false

        # counter = 0
        # (1..4).each do |row|
        #    (1..4).each do |col|
        #         pos = [row,col]
        #         card = self[pos]
        #         if card.face_up == true
        #             counter += 1
        #         end
        #    end
        # end
        # if counter == 16
        #     return true
        # end
        # false
    end

    def reveal
        (1..4).each do |row|
           (1..4).each do |col|
                pos = [row,col]
                card = self[pos]
                card.reveal
           end
        end
        
    end

end

    if __FILE__ == $PROGRAM_NAME
        c2 = Card.random_card
        c1 = Card.random_card
        load 'board.rb'
        b = Board.new
        b.populate
        b.render
    end