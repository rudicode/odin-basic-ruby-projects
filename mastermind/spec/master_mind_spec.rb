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
      expect(@game.guess_number).to eq(1)
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
      expect {@game.make_guess([1,2,3,4])}.to change {@game.guess_number}.by(1)
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
end
