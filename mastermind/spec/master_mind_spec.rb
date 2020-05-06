require "master_mind"

RSpec.describe MasterMind do
  before(:example) do
    @game = MasterMind.new( [1,2,3,4] )
  end

  describe '#setup_new_game' do

    before(:example) do
      @game.setup_new_game([3,4,5,6])
    end

    it 'has solution set correctly' do
      expect(@game.solution).to eq([3,4,5,6])
    end

    it 'has @guess_number set to 1' do
      expect(@game.current_guess_number).to eq(1)
    end

    it 'sets @guess array to empty' do
      expect(@game.guesses).to eq([])
    end

    it 'sets win? to nil or false' do
      expect(@game.win?).to be_falsy
    end

    it 'sets @max_guesses default to 12' do
      expect(@game.max_guesses).to be == 12
    end

  end

  describe '#make_guess' do

    it "incraments @guess_number by 1" do
      expect {@game.make_guess([1,2,3,4])}.to change {@game.current_guess_number}.by(1)
    end

    it "adds guess to @guesses array" do
      @game.make_guess([5,5,5,5])
      expect(@game.guesses[-1][:guess]).to eq([5,5,5,5])
      expect(@game.guesses[-1][:correct_positions]).to_not be_nil
      expect(@game.guesses[-1][:correct_numbers]).to_not be_nil
    end

    it "finds how many correct positions" do
      @game.make_guess([1,5,5,5])
      expect(@game.guesses[-1][:correct_positions]).to eq(1)
      @game.make_guess([1,2,5,4])
      expect(@game.guesses[-1][:correct_positions]).to eq(3)
    end

    it "finds how many correct numbers" do
      @game.make_guess([5,5,5,1])
      expect(@game.guesses[-1][:correct_numbers]).to eq(1)
      @game.make_guess([4,3,2,1])
      expect(@game.guesses[-1][:correct_numbers]).to eq(4)
    end

    it "finds both correct positions and numbers" do
      @game.setup_new_game([6,5,6,1])
      @game.make_guess([6,5,1,6])
      expect(@game.guesses[-1][:correct_positions]).to eq(2)
      expect(@game.guesses[-1][:correct_numbers]).to eq(2)

      @game.make_guess([6,5,6,1])
      expect(@game.guesses[-1][:correct_positions]).to eq(4)
      expect(@game.guesses[-1][:correct_numbers]).to eq(0)

      @game.make_guess([1,6,5,6])
      expect(@game.guesses[-1][:correct_positions]).to eq(0)
      expect(@game.guesses[-1][:correct_numbers]).to eq(4)
    end

    it "finds correct positions and numbers if solution contains 3 same numbers" do
      @game.setup_new_game([2,2,2,3])
      @game.make_guess([1,2,2,2])
      expect(@game.guesses[-1][:correct_positions]).to eq(2)
      expect(@game.guesses[-1][:correct_numbers]).to eq(1)

      @game.make_guess([2,2,2,1])
      expect(@game.guesses[-1][:correct_positions]).to eq(3)
      expect(@game.guesses[-1][:correct_numbers]).to eq(0)
    end

    it "finds correct solution" do
      @game.setup_new_game([1,1,6,4])
      @game.make_guess([1,1,6,4])
      expect(@game.guesses[-1][:correct_positions]).to eq(4)
      expect(@game.guesses[-1][:correct_numbers]).to eq(0)
    end

    it "sets @win to true" do
      @game.setup_new_game([1,1,6,4])
      @game.make_guess([1,1,6,4])
      expect(@game.win?).to be_truthy
    end

    it "finds 0 positions and 0 numbers" do
      @game.setup_new_game([1,2,3,4])
      @game.make_guess([5,5,5,5])
      expect(@game.guesses[-1][:correct_positions]).to eq(0)
      expect(@game.guesses[-1][:correct_numbers]).to eq(0)
    end

  end

  describe '#guesses' do
    it "returns array of guesses" do
      @game.setup_new_game([1,2,3,4])
      @game.make_guess([5,5,5,5])
      @game.make_guess([4,5,5,5])
      @game.make_guess([1,5,5,5])
      result = [{:guess => [5,5,5,5], :correct_positions => 0, :correct_numbers => 0},
                {:guess => [4,5,5,5], :correct_positions => 0, :correct_numbers => 1},
                {:guess => [1,5,5,5], :correct_positions => 1, :correct_numbers => 0}]
      expect(@game.guesses).to eq(result)
    end

  end

  describe '#valid_digits' do
    context 'input as String' do

      it "returns array of num_digits digits" do
        expect(@game.valid_digits("123", 3)).to eq([1,2,3])
        expect(@game.valid_digits("1234", 4)).to eq([1,2,3,4])
        expect(@game.valid_digits("12345", 5)).to eq([1,2,3,4,5])
      end


      it "returns nil if string length is not num_digits length" do
        expect(@game.valid_digits("12345", 4)).to be_nil
      end

      it "returns nil if any characters are non-digits" do
        expect(@game.valid_digits("1hi3", 4)).to be_nil
      end
      it "all digits are within min..max" do
        @game.min_digit=3
        @game.max_digit=6
        expect(@game.valid_digits("2444", 4)).to be_nil
        expect(@game.valid_digits("4449", 4)).to be_nil

      end
    end

    context "input as Array" do
      it "also works correctly" do
        expect(@game.valid_digits([2,3,2,3], 4)).to eq([2,3,2,3])
      end
      it "also rejects bad data" do
        expect(@game.valid_digits([2,"h","i",3], 4)).to be_nil
        expect(@game.valid_digits([2,1,2,3,7], 3)).to be_nil
      end

    end

  end

  describe '#create_random_solution' do
    it "sets solution to valid digits" do
      @game = MasterMind.new([1,2,3,4])
      @game.setup_new_game()
      expect(@game.solution.length).to eq(@game.num_digits)
      expect(@game.valid_digits(@game.solution,@game.num_digits)).to eq(@game.solution)
    end
  end

end
