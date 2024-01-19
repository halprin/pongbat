class MainGameScene < Scene
  def initialize(args)
    super('main_game', args)

    @left_score = 0
    @right_score = 0

    @left_paddle = Paddle.new(args, 'blue.png', args.grid.left + 10, args.grid.top - Paddle.height - 200)
    @right_paddle = Paddle.new(args, 'red.png', args.grid.right - Paddle.width - 10, args.grid.top - Paddle.height - 200)

    @ui_bottom = args.grid.top - 80

    @balls = {}

    @blocks = {}

    @explosions = {}

    @paddles = [@left_paddle, @right_paddle]

    reset_round

  end

  def reset_round
    @balls.clear
    @blocks.clear
    @explosions.clear

    number_of_balls = rand(10) + 1

    number_of_balls.each { |_|
      create_random_ball
    }

    number_of_blocks = rand(5) + 1

    number_of_blocks.each { |_|
      create_random_block
    }

    an_explosion = Explosion.new(@args, 300, 300, @explosions)
    @explosions[an_explosion.object_id] = an_explosion

    @sprites = [@paddles, @balls.values, @blocks.values, @explosions.values]

    @next_block_creation_frame = (rand(10) + 1) * 60 + @args.state.tick_count  # random between 1 - 10 seconds from now
  end

  def create_random_ball
    third_of_width = @args.grid.w / 3
    third_of_height = (@args.grid.h - (@args.grid.h - @ui_bottom)) / 3

    random_start_x = rand(third_of_width) + third_of_width
    random_start_y = rand(third_of_height) + third_of_height

    new_ball = UnclaimedBall.new(@args, random_start_x, random_start_y)

    puts "creating new ball #{new_ball.object_id}"
    @balls[new_ball.object_id] = new_ball
  end

  def create_random_block
    fourth_of_width = @args.grid.w / 4
    fourth_of_height = (@args.grid.h - (@args.grid.h - @ui_bottom)) / 4

    random_start_x = rand(fourth_of_width * 2) + fourth_of_width
    random_start_y = rand(fourth_of_height * 2) + fourth_of_height

    block_choice = rand(6)
    # block_choice = 5
    case block_choice
    when 0
      new_block = SpeedUpBlock.new(@args, random_start_x, random_start_y, @blocks)
    when 1
      new_block = SpeedDownBlock.new(@args, random_start_x, random_start_y, @blocks)
    when 2
      new_block = ExtraBallBlock.new(@args, random_start_x, random_start_y, method(:create_random_ball), @blocks)
    when 3
      new_block = RemoveBallBlock.new(@args, random_start_x, random_start_y, @balls, @blocks)
    when 4
      new_block = DrunkBallBlock.new(@args, random_start_x, random_start_y, @balls, @blocks)
    when 5
      new_block = BombBallBlock.new(@args, random_start_x, random_start_y, @balls, @blocks)
    end

    puts "creating new block #{new_block.object_id}"
    @blocks[new_block.object_id] = new_block
  end

  def tick(args)
    @sprites = [@paddles, @balls.values, @blocks.values, @explosions.values]
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
    ball_pass_right_paddle
    ball_pass_left_paddle
    ball_collision_check_with_blocks

    paddles_collision_with_top
    paddles_collision_with_bottom

    decide_to_make_next_block

    @sprites.each { |sprite_group| sprite_group.each { |sprite| sprite.calculate(@args) } }

  end

  def ball_collision_check_with_left_paddle
    @balls.each_value do |ball|
      if @left_paddle.collide_right(ball)
        ball.bounce_sides
        @balls.delete(ball.object_id)
        claimed_ball = BlueBall.new(@args, ball)
        claimed_ball.x = @left_paddle.right_x
        @balls[claimed_ball.object_id] = claimed_ball
      elsif @left_paddle.collide_top(ball) || @left_paddle.collide_bottom(ball)
        ball.bounce_top_bottom
        @balls.delete(ball.object_id)
        claimed_ball = BlueBall.new(@args, ball)
        @balls[claimed_ball.object_id] = claimed_ball
      end
    end
  end

  def ball_collision_check_with_right_paddle
    @balls.each_value do |ball|
      if @right_paddle.collide_left(ball)
        ball.bounce_sides
        @balls.delete(ball.object_id)
        claimed_ball = RedBall.new(@args, ball)
        @balls[claimed_ball.object_id] = claimed_ball
        claimed_ball.x = @right_paddle.x - claimed_ball.w
      elsif @right_paddle.collide_top(ball) || @right_paddle.collide_bottom(ball)
        ball.bounce_top_bottom
        @balls.delete(ball.object_id)
        claimed_ball = RedBall.new(@args, ball)
        @balls[claimed_ball.object_id] = claimed_ball
      end
    end
  end

  def ball_collision_check_with_top
    @balls.each_value do |ball|
      ball.bounce_top_bottom if ball.top_y >= @ui_bottom
    end
  end

  def ball_collision_check_with_bottom
    @balls.each_value do |ball|
      ball.bounce_top_bottom if ball.y <= @args.grid.bottom
    end
  end

  def ball_pass_right_paddle
    @balls.delete_if { |ball_key, ball_value| ball_value.x > @args.grid.right }

    if @balls.length == 0
      @left_score += 1
      reset_round
    end
  end

  def ball_pass_left_paddle
    @balls.delete_if { |ball_key, ball_value| ball_value.right_x < @args.grid.left }

    if @balls.length == 0
      @right_score += 1
      reset_round
    end
  end

  def ball_collision_check_with_blocks
    @blocks.each_value do |block|
      @balls.each_value do |ball|
        if block.collide_left(ball)
          ball.bounce_sides
          ball.x = block.x - ball.w - 1
          block.apply_difference(ball)
        elsif block.collide_right(ball)
          ball.bounce_sides
          ball.x = block.x + block.w + 1
          block.apply_difference(ball)
        elsif block.collide_top(ball)
          ball.bounce_top_bottom
          ball.y = block.y + block.h + 1
          block.apply_difference(ball)
        elsif block.collide_bottom(ball)
          ball.bounce_top_bottom
          ball.y = block.y - ball.h - 1
          block.apply_difference(ball)
        end
      end
    end
  end

  def paddles_collision_with_top
    if @left_paddle.top_y >= @ui_bottom
      @left_paddle.prevent_up
    else
      @left_paddle.allow_up
    end

    if @right_paddle.top_y >= @ui_bottom
      @right_paddle.prevent_up
    else
      @right_paddle.allow_up
    end
  end

  def paddles_collision_with_bottom
    if @left_paddle.y <= @args.grid.bottom
      @left_paddle.prevent_down
    else
      @left_paddle.allow_down
    end

    if @right_paddle.y <= @args.grid.bottom
      @right_paddle.prevent_down
    else
      @right_paddle.allow_down
    end
  end

  def decide_to_make_next_block
    if @args.state.tick_count >= @next_block_creation_frame
      create_random_block
      @next_block_creation_frame = (rand(10) + 1) * 60 + @args.state.tick_count  # random between 1 - 10 seconds from now
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
