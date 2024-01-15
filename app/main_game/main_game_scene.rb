class MainGameScene < Scene
  def initialize(args)
    super('main_game', args)

    @left_score = 0
    @right_score = 0

    @left_paddle = Paddle.new(args, args.grid.left + 10, args.grid.top - Paddle.height - 200)
    @right_paddle = Paddle.new(args, args.grid.right - Paddle.width - 10, args.grid.top - Paddle.height - 200)

    @ui_bottom = args.grid.top - 80

    @balls = []

    reset_round

    @paddles = [@left_paddle, @right_paddle]

    @sprites = [@paddles, @balls]
  end

  def reset_round
    puts "New round"
    @ball = Ball.new(@args, @args.grid.right / 2, @args.grid.top / 2)

    @balls[0] = @ball
  end

  def tick(args)
    render
    calculations
    input_checking
  end

  def render
    @args.outputs.background_color = [255, 255, 255]
    @args.outputs.sprites << @sprites
    display_ui(@args)
  end

  def calculations
    ball_collision_check_with_left_paddle
    ball_collision_check_with_right_paddle
    ball_collision_check_with_top
    ball_collision_check_with_bottom
    ball_score_for_left_paddle
    ball_score_for_right_paddle
    @sprites.each { |sprite_group| sprite_group.each { |sprite| sprite.calculate(@args) } }
  end

  def ball_collision_check_with_left_paddle
    @ball.bounce_sides if @left_paddle.collide_right(@ball)
    @ball.bounce_top_bottom if @left_paddle.collide_top(@ball) || @left_paddle.collide_bottom(@ball)
  end

  def ball_collision_check_with_right_paddle
    @ball.bounce_sides if @right_paddle.collide_left(@ball)
    @ball.bounce_top_bottom if @right_paddle.collide_top(@ball) || @right_paddle.collide_bottom(@ball)
  end

  def ball_collision_check_with_top
    @ball.bounce_top_bottom if @ball.top_y >= @ui_bottom
  end

  def ball_collision_check_with_bottom
    @ball.bounce_top_bottom if @ball.y <= @args.grid.bottom
  end

  def ball_score_for_left_paddle
    if @ball.x > @args.grid.right
      @left_score += 1
      reset_round
    end
  end

  def ball_score_for_right_paddle
    if @ball.right_x < @args.grid.left
      @right_score += 1
      reset_round
    end
  end

  def input_checking
    @right_paddle.move_up if right_paddle_up_pressed_no_down
    @right_paddle.move_down if right_paddle_down_pressed_no_up
    @left_paddle.move_up if left_paddle_up_pressed_no_down
    @left_paddle.move_down if left_paddle_down_pressed_no_up
  end

  def right_paddle_up_pressed_no_down
    @args.inputs.keyboard.up_arrow && !@args.inputs.keyboard.down_arrow
  end

  def right_paddle_down_pressed_no_up
    @args.inputs.keyboard.down_arrow && !@args.inputs.keyboard.up_arrow
  end

  def left_paddle_up_pressed_no_down
    @args.inputs.keyboard.w && !@args.inputs.keyboard.s
  end

  def left_paddle_down_pressed_no_up
    @args.inputs.keyboard.s && !@args.inputs.keyboard.w
  end

  def display_ui(args)
    # background
    args.outputs.solids << [args.grid.left, @ui_bottom, args.grid.right, args.grid.top]

    # score
    args.outputs.labels << [args.grid.left, args.grid.top, 'Left Score', 0, 0, 255, 255, 255]
    args.outputs.labels << [args.grid.left, args.grid.top - 16, format('%04d', @left_score), 5, 0, 255, 255, 255]

    args.outputs.labels << [args.grid.left + 150, args.grid.top, 'Right Score', 0, 0, 255, 255, 255]
    args.outputs.labels << [args.grid.left + 150, args.grid.top - 16, format('%04d', @right_score), 5, 0, 255, 255, 255]

    # time
    args.outputs.labels << [args.grid.left + 300, args.grid.top, 'Time', 0, 0, 255, 255, 255]
    seconds = format('%05.2f', (0.elapsed_time / 60 % 60))
    minutes = format('%02d', (0.elapsed_time / 60 / 60 % 60))
    hours = format('%02d', (0.elapsed_time / 60 / 60 / 60))
    args.outputs.labels << [args.grid.left + 300, args.grid.top - 16, "#{hours}:#{minutes}:#{seconds}", 5, 0, 255, 255,
                            255]
  end
end
