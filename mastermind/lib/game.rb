require "./lib/player"
require "./lib/colors"
require "./lib/master_mind"
require "./lib/game_io"

class Game
  include Colors

  def initialize
    @game_io = GameIo.new(80,40)
  end
  def start
    display_empty_game_board(1,1)
  end

  def display_empty_game_board(column, line)
    board = []
    board[0]= "┌───┬───┬───┐"
    board[1]= "│ #{BLDGRN}●#{TXTRST} │ █ │ ³ │░"
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

end
