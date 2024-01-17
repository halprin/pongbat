class UnclaimedBall < Ball

  def initialize(args, starting_x, starting_y)
    dx = (rand(5) + 1) * [1, -1].sample
    dy = (rand(5) + 1) * [1, -1].sample
    super(args, 'unclaimed.png', starting_x, starting_y, dx, dy)

  end

  # Action methods

  # Calculation methods

end
