class MasterMind
    attr_reader :solution, :guess_number, :guesses, :max_guesses
    def initialize(solution, max_guesses=12)
      @max_guesses = max_guesses
      setup_new_game(solution)
    end

    def setup_new_game(solution)
      @solution = solution
      @win = false
      @guesses = []
    end

    def win?
      return @win
    end

    def guess_number
      @guesses.length + 1
    end

    def make_guess(guess)
      cp,cn = guess_results(guess)
      @guesses << {:guess => guess, :correct_positions => cp, :correct_numbers => cn  }
      @win = true if cp == 4
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

      target.each do |x|
        guess_temp = guess.dup
        4.times do |y|
            if x == guess_temp[y]
              counter_numbers += 1
              # guess_temp[y] = 0
              break;
            end
        end

      end
      return  [counter_positions, counter_numbers - counter_positions]
    end
end
