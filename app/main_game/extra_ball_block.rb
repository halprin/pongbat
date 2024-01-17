class ExtraBallBlock < Block

  def initialize(args, starting_x, starting_y, create_new_ball, remove_block_function)
    super(args, 'plus.png', starting_x, starting_y, remove_block_function)
    @create_new_ball = create_new_ball
  end

  # Action methods

  def apply_difference(ball)
    @create_new_ball.call
  end

  # Calculation methods
end
