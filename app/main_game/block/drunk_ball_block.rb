class DrunkBallBlock < Block

  def initialize(args, starting_x, starting_y, balls, blocks)
    super(args, 'drunk.png', starting_x, starting_y, blocks)
    @balls = balls
  end

  # Action methods

  def apply_difference(ball)
    @balls.delete(ball.object_id)
    new_drunk_ball = DrunkBall.new(@args, ball)
    @balls[new_drunk_ball.object_id] = new_drunk_ball
  end

  # Calculation methods
end
