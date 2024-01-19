class BombBall < Ball

  def initialize(args, other_ball)
    super(args, 'bomb.png', other_ball.x, other_ball.y, other_ball.dx, other_ball.dy)
  end

  # Action methods

  # Calculation methods

end
