require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return board.won? && board.winner != evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.all? { |child_node| child_node.losing_node?(evaluator) }
    else
      self.children.any? { |child_node| child_node.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end

    if next_mover_mark == evaluator
      self.children.any? { |child_node| child_node.winning_node?(evaluator)}
    else
      self.children.all? { |child_node| child_node.winning_node?(evaluator)}
    end
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

        children_array << TicTacToeNode.new(duped_board, next_mover_mark, pos)
      end
    end

    children_array

  end
end
