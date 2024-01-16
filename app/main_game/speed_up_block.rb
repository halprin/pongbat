class SpeedUpBlock < Block

  def initialize(args, starting_x, starting_y, remove_block_function)
    super(args, 'speed_up.png', starting_x, starting_y, remove_block_function)
  end

  # Action methods

  def apply_difference(ball)
    ball.speed_up
  end

  # Calculation methods
end
