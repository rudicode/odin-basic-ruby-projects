class TicTacToe
  attr_reader :game_board, :winner
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @active_player = player1.id
    @winner = nil
    clear_game_board()
  end

  def setup_new_game(player1,player2)
    clear_game_board
    @active_player = player1.id
    @winner = nil
  end

  def clear_game_board
    @game_board = [0,0,0, 0,0,0, 0,0,0]
  end

  def make_move(move_string)
    # check move to see if it's valid
    # should be a number between 1-9 wher 5 is center square
    # 1 2 3
    # 4 5 6
    # 7 8 9
    #
    return nil if move_string.length > 1
    move = move_string.to_i
    valid_positions = [1,2,3,4,5,6,7,8,9]
    return nil unless valid_positions.include?(move)
    # check if that move is avaliable
    return nil if @game_board[move-1] != 0

    # mark that move with current player's turn
    @game_board[move-1] = @active_player
    check_for_winner
    toggle_active_player
    return move
  end

  def check_for_winner
    # for array use the following index ( 4 is center square )
    # 0,1,2
    # 3,4,5
    # 6,7,8

    winner = nil
    winning_patterns = [[0,1,2], [3,4,5], [6,7,8],
                            [0,3,6], [1,4,7], [2,5,8],
                            [0,4,8], [2,4,6]]
    winning_patterns.each do |pattern|
      count_1 = 0
      count_2 = 0
      pattern.each do |x|
        count_1 += 1 if @game_board[x] == @player1.id
        count_2 += 1 if @game_board[x] == @player2.id
      end
      @winner = @player1 if count_1 == 3
      @winner = @player2 if count_2 == 3
      @winner = "tie" if !@game_board.include?(0)
    end
  end

  def toggle_active_player
    @active_player == @player1.id ? @active_player = @player2.id : @active_player = @player1.id
  end

  def active_player
    @active_player == @player1.id ? @player1 : @player2
  end

end
