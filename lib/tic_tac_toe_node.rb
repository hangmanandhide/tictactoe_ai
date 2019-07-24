require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return board.over? && 
  end

  def winning_node?(evaluator)
    board.over? == evaluator
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  #To create this method, it will be necessary to iterate through all positions that are empty? on the board object. For each empty position, create a node by duping the board and putting a next_mover_mark in the position.
  def children
    children_array = []

    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        next unless @board.empty?(pos)

        duped_board = board.dup
        duped_board[pos] = self.next_mover_mark
        next_mover_mark = (self.next_mover_mark == :x ? :o : :x)

        children << TicTacToeNode.new(duped_board, next_mover_mark, pos)
      end
    end

    children

  end
end
