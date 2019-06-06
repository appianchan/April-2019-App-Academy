class Array

    def uniq
        ans = []
        self.each { |el| ans << el if !ans.include?(el) }
        ans
    end

    def two_sum
        ans = []

        (0...length-1).each do |el|
            (el+1...length).each do |el2|
                ans << [el, el2] if self[el] + self[el2] == 0
            end
        end
        ans
    end
    
end

def my_transpose(matrix)
    transpose = Array.new(matrix.length) { [] }
    matrix.each do |subarray|
        subarray.each_with_index do |element, index|
        transpose[index] << element
        end
    end
    transpose
end

# def stock_picker(prices)
#     profit = 0
#     buy = 0
#     sell = 0
    
#     (0...prices.length-1).each do |el|
#         (el+1...prices.length).each do |el2|
#             diff = prices[el2] - prices[el]
#             if diff > profit
#                 buy = el
#                 sell = el2
#                 profit = diff
#             end
#         end
#     end
    
#     [buy, sell]
# end

def stock_picker(prices)
    diff, days = [], []

    (0...prices.length-1).each do |el|
        (el+1...prices.length).each do |el2|
            diff << prices[el2] - prices[el]
            days << [el, el2]
        end
    end

    days[diff.index(diff.max)]

end

class Hanoi
    attr_accessor :game
    def initialize(pegs)
        @pegs = pegs
        @game = Array.new(pegs) {Array.new}
        (1..pegs).each { |disc| @game[0] << disc }
    end

    def move(from, to)

        if game[from - 1].count >= 1
            if game[to - 1].count >= 1
                if game[from - 1].first > game[to - 1].first
                    raise "can't place a big piece on a small piece"
                else
                    game[to - 1].unshift(game[from - 1].shift)
                end 
            else
                game[to - 1].unshift(game[from - 1].shift)
            end
        else
            raise 'nothing to move'
        end

    end

    def won?
        game[1..-1].any?{|peg|peg == (1..@pegs).to_a}
    end

    def play
        until won? do
            p game
            puts 'input from and to (ex: 1 2)'
            from_to = gets.chomp.split(' ')
            exit! if %w(exit quit stop).include?(from_to[0])
            from, to = from_to
            from, to = from.to_i, to.to_i
            move(from, to)
        end
    end

end

# Hanoi.new(3).play


