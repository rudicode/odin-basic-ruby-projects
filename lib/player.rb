class Player
  attr_accessor :name, :points, :letter

  def initialize(name, points=0)
    @name = name
    @points = points
  end
end
