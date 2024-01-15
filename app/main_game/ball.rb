class Ball < Sprite

  @@width = 20
  @@height = 20

  def initialize(args, starting_x, starting_y)
    super(args, '/sprites/ball/unclaimed.png', starting_x, starting_y, @@width, @@height)

    @dx = (rand(5) + 1) * [1, -1].sample
    @dy = (rand(5) + 1) * [1, -1].sample

  end

  # Action methods

  def bounce_sides
    @dx *= -1
  end

  def bounce_top_bottom
    @dy *= -1
  end

  # Calculation methods

  def calculate(args)
    move_ball
  end

  def move_ball
    @x += @dx
    @y += @dy
  end
end
