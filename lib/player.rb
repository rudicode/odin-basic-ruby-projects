class Player
  attr_accessor :name, :points

  def initialize(name, points=0)
    @name = name
    @points = points
  end
end
