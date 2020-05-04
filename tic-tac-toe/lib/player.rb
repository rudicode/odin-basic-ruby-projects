class Player
  attr_accessor :name, :points, :letter
  attr_reader :id

  def initialize(name, id, points=0)
    @name = name
    @id = id
    @points = points
  end
end
