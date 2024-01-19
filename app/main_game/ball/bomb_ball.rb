class BombBall < Ball

  def initialize(args, other_ball, explosions)
    super(args, 'bomb.png', other_ball.x, other_ball.y, other_ball.dx, other_ball.dy)
    @explosions = explosions
  end

  # Action methods

  def ball_passes_paddle
    new_explosion = Explosion.new(@args, @x, @y, @explosions)
    @explosions[new_explosion.object_id] = new_explosion
  end

  # Calculation methods

end
