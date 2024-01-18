class DrunkBall < Ball

  def initialize(args, other_ball)
    super(args, 'drunk.png', other_ball.x, other_ball.y, other_ball.dx, other_ball.dy)

    @next_change_frame = (rand(4) + 1) * 60 + args.state.tick_count  # random between 1 - 4 seconds from now
  end

  # Action methods

  # Calculation methods

  def calculate(args)
    if @args.state.tick_count >= @next_change_frame
      randomly_change_dy
      @next_change_frame = (rand(4) + 1) * 60 + args.state.tick_count  # random between 1 - 4 seconds from now
    end

    super(args)
  end

  def randomly_change_dy
    if @dy.abs != 1
      @dy = (rand(5) + 1) * (@dy / @dy.abs)
    else
      swap_direction = rand(2)
      if swap_direction == 1
        @dy *= -1
      else
        @dy = (rand(5) + 1) * (@dy / @dy.abs)
      end
    end
  end

end
