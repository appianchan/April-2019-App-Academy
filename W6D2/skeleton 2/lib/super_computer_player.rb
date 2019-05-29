require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # debugger
    # evaluator = nil
    # mark == :o ? evaluator = :x : evaluator = :o
    new_node = TicTacToeNode.new(game.board, mark)
    new_children = new_node.children
    new_children
    new_children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end       
    end

    # there was an issue with our children method

    new_children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end        
    end

    raise "no winning or draws"
  end
  # p child.winning_node?(mark)  

  # new_children.map do |child|
    #   child = child.prev_move_pos        
    # end
    # new_children
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
