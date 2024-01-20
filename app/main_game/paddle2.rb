class Paddle2 < Solid
  @@speed = 4
  @@width = 20
  @@height = 200

  def initialize(args, starting_x, starting_y, color)
    color_splat = if color == :red
                    [255, 0, 0]
                  else
                    [0, 0, 255]
                  end


    super(args, starting_x, starting_y, @@width, @@height, *color_splat)

    @allow_up = true
    @allow_down = true
  end

  def self.width
    return @@width
  end

  def self.height
    return @@height
  end

  # Action methods
  def move_up
    return unless @allow_up
    @y += @@speed
  end

  def move_down
    return unless @allow_down
    @y -= @@speed
  end

  def prevent_up
    @allow_up = false
  end

  def allow_up
    @allow_up = true
  end

  def prevent_down
    @allow_down = false
  end

  def allow_down
    @allow_down = true
  end

  def collide_left(other_sprite)
    return other_sprite.intersect_rect?({
                                          x: @x,
                                          y: @y,
                                          w: 1,
                                          h: @h
                                        })
  end

  def collide_right(other_sprite)
    return other_sprite.intersect_rect?({
                                          x: @x + @w - 1,
                                          y: @y,
                                          w: 1,
                                          h: @h
                                        })
  end

  def collide_top(other_sprite)
    return other_sprite.intersect_rect?({
                                          x: @x,
                                          y: @y + @h -1,
                                          w: @w,
                                          h: 1
                                        })
  end

  def collide_bottom(other_sprite)
    return other_sprite.intersect_rect?({
                                          x: @x,
                                          y: @y,
                                          w: @w,
                                          h: 1
                                        })
  end

  def center
    center_x = @x + @w / 2
    center_y = @y + @h / 2

    return [center_x, center_y]
  end

  def top_y
    return @y + @h
  end

  def right_x
    return @x + @w
  end

  # Calculation methods

  def calculate(args)

  end
end
