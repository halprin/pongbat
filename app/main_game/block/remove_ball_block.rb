class RemoveBallBlock < Block

  def initialize(args, starting_x, starting_y, balls, blocks)
    super(args, 'minus.png', starting_x, starting_y, blocks)
    @balls = balls
  end

  # Action methods

  def apply_difference(ball)
    @balls.delete(ball.object_id)
  end

  # Calculation methods
end
