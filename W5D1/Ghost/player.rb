# require_relative "game.rb"
class Player
    attr_accessor :losses
    attr_reader :name
    def initialize(name)
        @name = name
        @losses = 0
    end

    def guess
        input = gets.chomp
        input[0]
    end
end