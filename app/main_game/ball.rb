class Ball < Sprite

  @@width = 40
  @@height = 40

  def initialize(args, starting_x, starting_y)
    super(args, '/sprites/ball/red.png', starting_x, starting_y, @@width, @@height)

    @dx = 1
    @dy = 1

  end

  def calculate(args)
    move_ball
  end

  def move_ball
    @x += @dx
    @y += @dy
  end
end
