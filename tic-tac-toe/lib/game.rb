require "./lib/player"
require "./lib/tic_tac_toe"
require "./lib/game_io"

class Game
  def initialize
    @game_board_pos_x = 15
    @game_board_pos_y = 3
    @game_io = GameIo.new(30, 20)
    @player1 = nil
    @player2 = nil
    @tic_tac_toe = nil
    setup_game
  end

  def setup_game
    @game_io.clear_screen

    name = @game_io.get_string("Enter player 1 name: ",2 ,2)
    name = "Billy" if name == ""
    @player1 = Player.new(name, 1, 0)
    @player1.letter = "X"

    name = @game_io.get_string("Enter player 2 name: ",2, 4)
    name = "Kristina" if name == ""
    @player2 = Player.new(name, 2, 0)
    @player2.letter = "O"

    @tic_tac_toe = TicTacToe.new(@player1, @player2)

  end

  def start
    setup_game if @player1 == nil
    @game_io.put_string("Game between #{@player1.name} and #{@player2.name}", 2, 7)
    input = @game_io.get_string("Press Enter to start, \'q\' anytime to quit.",2, 9)
    return if input == 'q'

    game_status = "play"
    while game_status != "exit"
      # draw game board
      @game_io.clear_screen
      display_game_board(@tic_tac_toe.game_board, @game_board_pos_x, @game_board_pos_y)
      display_player_info()

      # get current players move
      move = player_prompt(@tic_tac_toe.active_player,12,2)
      game_status = "exit" if move == 'q'
      move_result  = @tic_tac_toe.make_move(move)


      who_won = @tic_tac_toe.winner

      if who_won == @player1 || who_won == @player2
        who_won.points += 1
        @game_io.clear_screen
        display_game_board(@tic_tac_toe.game_board, @game_board_pos_x, @game_board_pos_y)
        display_player_info()
        @game_io.put_string("#{who_won.name} won the game.", 2, 16)
        game_status = "win"
      end

      if who_won == "tie"
        @game_io.put_string("Tie game.", 2, 16)
        game_status = "tie"
      end

      if game_status == "win" || game_status == "tie"
        @game_io.get_string("push ENTER to continue.",2, 18)
        if @tic_tac_toe.winner == @player1
          @tic_tac_toe.setup_new_game(@player2,@player1)
        else
          @tic_tac_toe.setup_new_game(@player1,@player2)
        end
        game_status = "play"
      end
    end
    @player1.points > @player2.points ? exit_text = "#{@player1.name} wins." : exit_text = "#{@player2.name} wins."
    exit_text = "It's a tie." if @player1.points == @player2.points
    @game_io.put_string(exit_text,1, 16)
  end

  def display_game_board(game_board, column, line)
    display_empty_board(line,column)
    position_pairs = [[1,2],[1,6],[1,10], [3,2],[3,6],[3,10],  [5,2],[5,6],[5,10]]

    game_board.each_with_index do |value, index|
      character = ""
      character = "X" if value == 1
      character = "O" if value == 2
      c = position_pairs[index][1]+column
      l = position_pairs[index][0]+line
      @game_io.put_string(character,c ,l)
    end
  end

  def display_empty_board(line,column)
    # top left of screen is (1,1)
    line   = 1 if line   < 1
    column = 1 if column < 1
    # small superscript numbers: ⁰¹²³⁴⁵⁶⁷⁸⁹
    # small subscript   numbers: ₀₁₂₃₄₅₆₇₈₉₀
    board = []
    board[0]= "┌───┬───┬───┐"
    board[1]= "│ ¹ │ ² │ ³ │░"
    board[2]= "├───┼───┼───┤░"
    board[3]= "│ ⁴ │ ⁵ │ ⁶ │░"
    board[4]= "├───┼───┼───┤░"
    board[5]= "│ ⁷ │ ⁸ │ ⁹ │░"
    board[6]= "└───┴───┴───┘░"
    board[7]= " ░░░░░░░░░░░░░"

    board.each_with_index do |text,index|
      @game_io.put_string(text, column, line+index)
    end
  end

  def player_prompt(player, line, column)
    text = "#{player.name} [#{player.letter}] play a position (1-9): "
    @game_io.get_string(text, column, line)
  end

  # def display_player_info(@player1, @player2)
  def display_player_info()
    space_width = @game_board_pos_x # make the width of the space same as x pos of game board
    p1_name_center = (space_width-@player1.name.length) / 2
    p1_letter_center = (space_width-3) / 2
    p1_points_center = space_width / 2
    @game_io.put_string("#{@player1.name}", p1_name_center, 4)
    @game_io.put_string("[#{@player1.letter}]", p1_letter_center, 6)
    @game_io.put_string("#{@player1.points}", p1_points_center, 8)

    game_board_width = 14
    p2_name_center   = ( (space_width-@player2.name.length) / 2 ) + space_width + game_board_width
    p2_letter_center = ( (space_width-3) / 2 ) + space_width + game_board_width
    p2_points_center = ( space_width / 2 ) + space_width + game_board_width
    @game_io.put_string("#{@player2.name}", p2_name_center, 4)
    @game_io.put_string("[#{@player2 .letter}]", p2_letter_center, 6)
    @game_io.put_string("#{@player2.points}", p2_points_center, 8)
  end

end
