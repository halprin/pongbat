class BombBallBlock < Block

  def initialize(args, starting_x, starting_y, balls, blocks)
    super(args, 'bomb.png', starting_x, starting_y, blocks)
    @balls = balls
  end

  # Action methods

  def apply_difference(ball)
    @balls.delete(ball.object_id)
    new_bomb_ball = BombBall.new(@args, ball)
    @balls[new_bomb_ball.object_id] = new_bomb_ball
  end

  # Calculation methods
end
