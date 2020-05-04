require "./lib/player"
require "./lib/tic_tac_toe"
require "./lib/game_io"

class Game
  # setup 2 players ( get names )
  # start TicTacToe game with the players ( winner of previous game goes 2nd )
  # keep points ( 1 point for a win )
  # handle CLI
  def initialize
  end

  def start
    # setup game parameters and then loop until exit
    @game_io = GameIo.new(30, 20)
    @game_io.clear_screen

    name = @game_io.get_string("Enter player 1 name: ",2 ,2)
    player1 = Player.new(name, 0)

    name = @game_io.get_string("Enter player 2 name: ",2, 4)
    player2 = Player.new(name, 0)

    @tic_tac_toe = TicTacToe.new(player1, player2)

    @game_io.put_string("Game between #{player1.name} and #{player2.name}", 2, 7)
    input = @game_io.get_string("Press Enter to start, \'q\' anytime to quit.",2, 9)
    return if input == 'q'

    status = "play"
    while status != "exit"
      # draw game board
      display_game_board(@tic_tac_toe.game_board, 10, 3)
      display_player_prompt(@tic_tac_toe.active_player,12,2)

      # get current players move
      move = gets.chomp
      status = "exit" if move == 'q'
      # make move in tic_tac_toe
      move_result  = @tic_tac_toe.make_move(move)
      if move_result
        puts "Marked #{move_result}"
      else
        puts "Can't go there."
      end
      # check if there was a winner and display win screen
      display_game_board(@tic_tac_toe.game_board, 10, 3)
      # who_won = @tic_tac_toe.check_for_winner
      who_won = @tic_tac_toe.winner

      if who_won == player1 || who_won == player2
        @game_io.put_string("#{who_won.name} won the game.", 2, 16)
        status = "win"
      end

      if who_won == "tie"
        @game_io.put_string("Tie game.", 2, 16)
        status = "tie"
      end

      if status == "win" || status == "tie"
        @game_io.put_string("push ENTER to continue.",2, 18)
        gets.chomp
        # setup for another game
        @tic_tac_toe.setup_new_game(player1,player2)
        status = "play"
      end
    end
    @game_io.put_string("",1, 16)
    # print"\033[16;1H"
  end

  def get_player_name(prompt)
    # return a random name for now
    name = ["Alice", "Betty", "Courtney", "Dorris", "Emily", "Fiona", "Goldie",
            "Heather", "Irene", "Joanne", "Kristina", "Linda"].sample
  end

  def display_game_board(game_board, column, line)
    # line = 2
    # column = 10
    # @game_io.clear_screen
    # print"\033[2J\033[1;1H" # clear screen and set cursor to 1,1
    display_empty_board(line,column)
    position_pairs = [[1,2],[1,6],[1,10], [3,2],[3,6],[3,10],  [5,2],[5,6],[5,10]]

    game_board.each_with_index do |value, index|
      character = ""
      character = "X" if value == 1
      character = "O" if value == 2
      # print"\033[#{position_pairs[index][0]+line};#{position_pairs[index][1]+column}H#{character}"
      c = position_pairs[index][1]+column
      l = position_pairs[index][0]+line
      @game_io.put_string(character,c ,l)
    end
    # puts "\n"
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
      @game_io.put_string(text,column, line+index)
    end
  end

  def display_player_prompt(player, line, column)
    # line = 11
    # column = 2
    # print"\033[#{line};#{column}H"
    text = "It's #{player.name}s turn. Which position: "
    @game_io.put_string(text, column, line)
  end

  def display_message(text, line, column)
    puts "display_message has been depricated. Change it to @game_io.put_string"
    # print"\033[#{line};#{column}H#{text}"
    # @game_io.put_string(text)
  end

end
