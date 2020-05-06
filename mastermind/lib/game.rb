require "pry"
require "./lib/player"
require "./lib/colors"
require "./lib/master_mind"
require "./lib/game_io"

class Game
  include Colors

  def initialize
    @game_io = GameIo.new(80,40)
    @mastermind = MasterMind.new([6,5,1,2])
    @display_code = false
    @score = 0
    @pos_x = 16
    @pos_y = 2
    @message = "Welcome to MasterMind."
  end

  def start
    status = :starting
    while status != :exit
      if status == :starting
        @mastermind.setup_new_game()
        status = :play
      end

      if status == :play || status == :finished
        @game_io.clear_screen
        display_game_board(@pos_x, @pos_y)
        display_message
        input = @game_io.get_string("> ",@pos_x , @pos_y + 34)
        status = :exit if input == 'q'
      end

      if status == :finished
        @display_code = false
        status = :starting
      end

      if status == :play
        result = @mastermind.make_guess( (input) )
        if !result
          @message = "Invalid input. Try 4 digits."
        else
          @message = "That was guess \##{result}"
        end

        if @mastermind.win?
          @message = "You Win in #{@mastermind.guesses.length} moves."
          @display_code = true
          @score += 1
          status = :finished
        end
        if @mastermind.current_guess_number > @mastermind.max_guesses
          @message = "Sorry out of turns. Hit enter to play again."
          @display_code = true
          status = :finished
        end
      end
    end
  end

  def display_message
    @game_io.put_string(@message, @pos_x+1, @pos_y+36)
    @message = ""
  end

  def display_game_board(column, line)
    # special characters  █ │³│░┌─┬┐└─┴┘─┼●┤├
    # ┌──┐ ┌───┬───┬───┬───┐ ┌───────┐
    # │11│░│   │   │   │   │░│● ● ● ●│░
    # ├──┤░├───┼───┼───┼───┤░├───────┤░
    # │12│░│   │   │   │   │░│● ● ● ●│░
    # └──┘░└───┴───┴───┴───┘░└───────┘░
    #  ░░░░ ░░░░░░░░░░░░░░░░░ ░░░░░░░░░

    board = []
    board << "#{BLDWHT}        M A S T E R M I N D"
    board << ""
    board << "#{P0[0]}┌──┐  ┌───┬───┬───┬───┐  ┌───────┐"

    12.times do |x|
      x+1 < 10 ? padding = " " : padding = ""
      board << "│#{x+1}#{padding}│░ │   │   │   │   │░ │● ● ● ●│░"
      board << "├──┤░ ├───┼───┼───┼───┤░ ├───────┤░" if (x+1 != 12)
    end

    board << "├──┤░ ├───┴───┴───┴───┤░ ├───────┤░"
    board << "│  │░ │               │░ │       │░"
    board << "├──┤░ ├───┬───┬───┬───┤░ ├───────┤░"
    board << "│->│░ │███│███│███│███│░ │<-     │░"
    board << "└──┘░ └───┴───┴───┴───┘░ └───────┘░"
    board << "  ░░░   ░░░░░░░░░░░░░░░░   ░░░░░░░░"
    board << ""
    legend = ""
    (1..6).each do |x| legend << P0[x] << " " end
    board << "Choose:  #{ legend }"

    board.each_with_index do |text,index|
      @game_io.put_string(text, column, line+index)
    end

    # draw filled gameboard
    guesses = @mastermind.guesses
    line_counter = 3
    guesses.each_index do |index|
      # 4 guesses
      a1 = guesses[index][:guess][0]
      a2 = guesses[index][:guess][1]
      a3 = guesses[index][:guess][2]
      a4 = guesses[index][:guess][3]
      @game_io.put_string(P0[ a1 ], column + 7, line_counter + line)
      @game_io.put_string(P0[ a2 ], column + 11, line_counter + line)
      @game_io.put_string(P0[ a3 ], column + 15, line_counter + line)
      @game_io.put_string(P0[ a4 ], column + 19, line_counter + line)

      # correct pegs (green)
      peg_counter = 4
      pegs = ""
      guesses[index][:correct_positions].times do |y|
        pegs << P0[8]
        peg_counter -= 1
        pegs << " " if peg_counter > 0
      end
      # correct number of pegs (red)
      guesses[index][:correct_numbers].times do |y|
        pegs << P0[9]
        peg_counter -= 1
        pegs << " " if peg_counter > 0
      end
      # incorrect pegs (dark gray)
      peg_counter.times do |y|
        pegs << P0[7]
        peg_counter -= 1
        pegs << " " if peg_counter > 0
      end
      # display pegs
      @game_io.put_string(pegs, column + 26, line_counter + line)
      line_counter += 2
    end
    if @display_code
      solution = @mastermind.solution
      solution.each_with_index do |x, i|
        @game_io.put_string(P0[x], column + 7 + (i * 4) , line + 29)
      end
    end
    @game_io.put_string("Wins: #{@score}", 4,5)
  end

end
