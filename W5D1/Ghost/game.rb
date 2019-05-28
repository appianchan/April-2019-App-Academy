# require '/Ghost/dictionary.txt'
require 'byebug'
require_relative "player.rb"
class Game
    LETTERS = "GHOST"
    attr_accessor :dictionary, :name1, :name2
    def initialize(name1, name2)
        @fragment = ''
        @players = [Player.new(name1), Player.new(name2)]
        @name1 = name1
        @name2 = name2
        @dictionary = Game.dictionary
        play
    end
    def self.dictionary
        dict_hash = Hash.new
        #hash for dictionary
        File.readlines("dictionary.txt").each do |word|
            word = word.chomp
            dict_hash[word] = 0
        end
        dict_hash
    end

    def current_player
        @players[0]
    end

    def previous_player
        @players[1]
    end

    def next_player!
        @players.rotate!
    end

    def take_turn(current_player)
        new_letter = current_player.guess
        @fragment = @fragment + new_letter
        #checking if fragment = a word in the dictionary
        passed = false
        while passed == false
            if valid_play?(@fragment)
                @dictionary.keys.each do |word|
                    #lose, on a completed word
                    if word[0..@fragment.length].include?(@fragment) && @fragment.length == word.length 
                        passed = true
                        current_player.losses += 1
                        print "#{current_player.name} gets a letter, you have #{LETTERS[0...current_player.losses]} \n\n\n\n"
                        @fragment = ''
                        end
                end
                # break
                passed = true
                p "turn complete"
                next_player!
            else
                p "guess again, no word contains that fragment"
                @fragment = @fragment[0..-2]
                new_letter = current_player.guess
                @fragment = @fragment + new_letter
            end
        end
    end

    def play
        until game_over?
            display
            take_turn(current_player)
        end
    end

    def display
        puts "The word is '#{@fragment}', choose your next letter wisely #{current_player.name}"
    end

    def game_over?
        @players.each do |player|
            if player.losses == 5
                print "GAME OVER!"
                return true
            end
        end
        false
    end

    def valid_play?(string)
        #substrings
        @dictionary.keys.each do |word|
            if word[0...string.length].include?(string) && string.length <= word.length
                return true
            end
        end
        return false
    end
    
end

Game.new("n1", "n2")

