class Paddle < Sprite

  @@speed = 4
  @@width = 20
  @@height = 200

  def initialize(args, starting_x, starting_y)
    super(args, '/sprites/paddle/paddle.png', starting_x, starting_y, @@width, @@height)
  end

  def self.width
    return @@width
  end

  def self.height
    return @@height
  end

  # Action methods
  def move_up
    @y += @@speed
  end

  def move_down
    @y -= @@speed
  end

  # Calculation methods

  def calculate(args)

  end
end
