require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
     return board.winner != evaluator && board.won?
    end

    if evaluator == self.next_mover_mark
      # do logic for player turn
      self.children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
      # do logic for opponent turn
      self.children.any? do |child|
        child.losing_node?(evaluator)
      end
    end

  end

  def winning_node?(evaluator)
    if board.over? 
      return board.winner == evaluator
    end

    if evaluator == self.next_mover_mark
      # do logic for player turn
      self.children.any? do |child|
        child.winning_node?(evaluator)
      end
    else
      # do logic for opponent turn
      self.children.all? do |child|
        child.winning_node?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children

    arr = []
      (0..2).each do |x|
        (0..2).each do |y|
          if @board[[x,y]].nil?
            new_board = @board.dup
            new_board[[x,y]] = next_mover_mark
              new_mark = nil
              next_mover_mark == :o ? new_mark = :x : new_mark = :o
            prev_move_pos = [x,y]
            arr << TicTacToeNode.new(new_board, new_mark, prev_move_pos)
          end
        end
      end
    arr
  end
end