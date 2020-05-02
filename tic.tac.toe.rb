#!/usr/bin/env ruby
# tic.tac.toe.rb
require 'pry'

class Player
  attr_accessor :name, :points

  def initialize(name)
    @name = name
    @points = 0
  end

end

class TicTacToe
  attr_reader :game_board, :winner
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @active_player = 1
    @winner = nil
    # @board = Array.new(9)
    clear_game_board()
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
    toggle_active_player
    return move
  end

  def check_for_winner
    # for array use the following index ( 4 is center square )
    # 0,1,2
    # 3,4,5
    # 6,7,8

    winner = nil
    winning_combinations = [[0,1,2], [3,4,5], [6,7,8],
                            [0,3,6], [1,4,7], [2,5,8],
                            [0,4,8], [2,4,6]]
    # binding.pry
    winning_combinations.each do |pattern|
      count_1 = 0
      count_2 = 0
      pattern.each do |x|
        count_1 += 1 if @game_board[x] == 1
        count_2 += 1 if @game_board[x] == 2
      end
      winner = @player1 if count_1 == 3
      winner = @player2 if count_2 == 3
      # binding.pry
    end

    return winner
  end

  def toggle_active_player
    @active_player == 1 ? @active_player = 2 : @active_player = 1
  end

  def active_player
    @active_player == 1 ? @player1 : @player2
  end

end

class Game
  # setup 2 players ( get names )
  # start TicTacToe game with the players ( winner of previous game goes 2nd )
  # keep points ( 1 point for a win )
  # handle CLI
  def initialize
  end

  def start
    # setup game parameters and then loop until exit
    name = get_player_name("Enter player 1 name:")
    player1 = Player.new(name)

    name = get_player_name("Enter player 2 name:")
    player2 = Player.new(name)

    p player1.name
    p player2.name
    ttt = TicTacToe.new(player1, player2)
    status = "play"
    while status && !ttt.winner
      # draw game board
      # p ttt.game_board
      display_game_board(ttt.game_board)
      display_player_prompt(ttt.active_player)
      # get current players move
      move = gets.chomp
      status = nil if move == 'q'
      # make play in ttt
      move_result = ttt.make_move(move)
      # p move_result
      if move_result
        puts "Marked #{move_result}"
      else
        puts "Can't go there."
      end
      # check if there was a winner and display win screen
      display_game_board(ttt.game_board)
      who_won = ttt.check_for_winner
      if who_won
        puts "#{who_won.name} won the game."
        status = "win"
      end
      break if status == "win"
    end

  end

  def get_player_name(prompt)
    # return a random name for now
    name = ["Alice", "Betty", "Courtney", "Dorris", "Emily", "Fiona", "Goldie",
            "Heather", "Irene", "Joanne", "Kristina", "Linda"].sample
  end

  def display_game_board(game_board)
    pos_line = 2
    pos_column = 10
    print"\033[2J\033[1;1H" # clear screen and set cursor to 1,1
    display_empty_board(pos_line,pos_column)
    # puts "\n"
    # game_board.each_with_index do |value, index|
    #   puts if index % 3 == 0
    #   print "X" if value == 1
    #   print "O" if value == 2
    #   print "·" if value != 1 && value != 2
    # end
    position_pairs = [[1,2],[1,6],[1,10], [3,2],[3,6],[3,10],  [5,2],[5,6],[5,10]]


    game_board.each_with_index do |value, index|
      character = ""
      character = "X" if value == 1
      character = "O" if value == 2
      print"\033[#{position_pairs[index][0]+pos_line};#{position_pairs[index][1]+pos_column}H#{character}"
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

    print "\033[#{line};#{column}f"
    board.each_with_index do |text,index|
      print"\033[#{line+index};#{column}H#{text}"
    end
  end

  def display_player_prompt(player)
    line = 11
    column = 2
    print"\033[#{line};#{column}H"
    print "It's #{player.name}s turn. Which position: "
  end

end

game = Game.new
game.start
