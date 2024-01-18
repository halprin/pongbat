class Ball < Sprite
  attr_accessor :dx, :dy

  @@width = 20
  @@height = 20

  def initialize(args, ball_image, starting_x, starting_y, dx, dy)
    super(args, '/sprites/ball/' + ball_image, starting_x, starting_y, @@width, @@height)
    @dx = dx
    @dy = dy
  end

  # Action methods

  def bounce_sides
    @dx *= -1
  end

  def bounce_top_bottom
    @dy *= -1
  end

  def speed_up
    # add 1 or subtract 1, depending on whether we already have a positive or negative dx, dy
    @dx += @dx / @dx.abs
    @dy += @dy / @dy.abs
  end

  def speed_down
    # add 1 or subtract 1, depending on whether we already have a positive or negative dx, dy
    if @dx != 1 && @dx != -1  # but don't drop speed to 0
      @dx -= @dx / @dx.abs
    end

    if @dy != 1 && @dy != -1  # but don't drop speed to 0
      @dy -= @dy / @dy.abs
    end
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
