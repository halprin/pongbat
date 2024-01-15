class SpeedUpBlock < Block

  def initialize(args, starting_x, starting_y)
    super(args, 'speed_up.png', starting_x, starting_y)
  end

  # Action methods
  #
  def apply_difference(ball)
    ball.speed_up
  end

  # Calculation methods
end
