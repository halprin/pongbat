class SpeedDownBlock < Block

  def initialize(args, starting_x, starting_y, blocks)
    super(args, 'speed_down.png', starting_x, starting_y, blocks)
  end

  # Action methods

  def apply_difference(ball)
    ball.speed_down
  end

  # Calculation methods
end
