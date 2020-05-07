
class MasterMind
    attr_reader :solution, :current_guess_number, :guesses, :max_guesses
    attr_accessor :min_digit, :max_digit, :num_digits

    def initialize(solution=nil, max_guesses=12, min_digit=1, max_digit=6)
      @max_guesses = max_guesses
      @min_digit = min_digit
      @max_digit = max_digit
      setup_new_game(solution)

    end

    def setup_new_game(solution=nil)
      @solution = solution || create_random_solution
      @num_digits = @solution.length
      @win = false
      @guesses = []
    end

    def create_random_solution
      arr = []
      (1..@num_digits).each do
        arr << rand(@min_digit..@max_digit)
      end
      return arr
    end

    def win?
      return @win
    end

    def current_guess_number
      @guesses.length + 1
    end

    def valid_digits(str, num_digits)

      str.class == Array ? string = str.join : string = str
      return nil if string.length != num_digits
      return nil if /\D/.match(string)

      minmax_flag = nil
      arr = string.split(//)
      arr.map! do|x|
        minmax_flag = true if x.to_i > @max_digit
        minmax_flag = true if x.to_i < @min_digit
        x.to_i
      end
      return nil if minmax_flag
      return arr
    end

    def make_guess(guess)
      valid_guess = valid_digits(guess, @num_digits)#, @solution.length)
      return nil if !valid_guess
      cp,cn = guess_results(valid_guess)
      @guesses << {:guess => valid_guess, :correct_positions => cp, :correct_numbers => cn  }
      @win = true if cp == 4
      return @guesses.length
    end

    private
    def guess_results(guess)
      target = @solution.dup
      counter_positions = 0
      counter_numbers   = 0

      target.each_index do |index|
        if target[index] == guess[index]
          counter_positions += 1
        end
      end

      guess_temp = guess.dup
      target.each do |x|
        4.times do |y|
            if x == guess_temp[y]
              counter_numbers += 1
              guess_temp[y] = 0
              break;
            end
        end

      end
      return  [counter_positions, counter_numbers - counter_positions]
    end
end
