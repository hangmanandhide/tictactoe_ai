require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    possible_moves = node.children

    a_winning_move = nil

    possible_moves.each do |child_node|
      if child_node.winning_node?(mark)
        a_winning_move  = child_node
        break
      end
    end

    return a_winning_move.prev_move_pos if a_winning_move

    possible_moves.each do |child_node|
      if !child_node.losing_node?(mark) 
        a_winning_move  = child_node
        break
      end
    end

    return a_winning_move.prev_move_pos if a_winning_move

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
