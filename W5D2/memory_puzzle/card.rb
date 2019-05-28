require_relative 'board.rb'

class Card
    ALPHABET = ('A'..'Z').to_a

    attr_accessor :value, :face_up

    def self.random_card
        letter = ALPHABET.sample
        Card.new(letter)        
    end

    def initialize(value)
        @value = value
        @face_up = false
    end

    def hide
        @face_up = false
    end


    def reveal
        @face_up = true
    end

    def to_s
        return "#{value}"
    end

    def ==(card)
        card.value == self.value
    end
    
end
