class Paddle2
  @@speed = 4
  @@width = 20
  @@height = 200

  def initialize(args, starting_x, starting_y, color)
    @args = args

    color_splat = if color == :red
                    [255, 0, 0]
                  else
                    [0, 0, 255]
                  end

    @allow_up = true
    @allow_down = true

    @solids = [Solid.new(args, starting_x, starting_y, @@width, @@height, *color_splat)]
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
    @solids.each { |solid| solid.y += @@speed }
    # @y += @@speed
  end

  def move_down
    return unless @allow_down
    @solids.each { |solid| solid.y -= @@speed }
    # @y -= @@speed
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
    return @solids.any? { |solid| 
             other_sprite.intersect_rect?({
                                            x: solid.x,
                                            y: solid.y,
                                            w: 1,
                                            h: solid.h
                                          })
    }
  end

  def collide_right(other_sprite)
    return @solids.any? { |solid|
      other_sprite.intersect_rect?({
                                     x: solid.x + solid.w - 1,
                                     y: solid.y,
                                     w: 1,
                                     h: solid.h
                                   })
    }
  end

  def collide_top(other_sprite)
    return @solids.any? { |solid|
      other_sprite.intersect_rect?({
                                     x: solid.x,
                                     y: solid.y + solid.h - 1,
                                     w: solid.w,
                                     h: 1
                                   })
    }
  end

  def collide_bottom(other_sprite)
    return @solids.any? { |solid|
      other_sprite.intersect_rect?({
                                     x: solid.x,
                                     y: solid.y,
                                     w: solid.w,
                                     h: 1
                                   })
    }
  end

  def break_with_explosion(explosion)
    @solids.each do |solid|
      (solid.y..(solid.y + solid.h)).each do |paddle_slice_y|
        paddle_line_affected_by_explosion = @args.geometry.circle_intersect_line?({x: explosion.center_x, y: explosion.center_y, radius: explosion.radius}, {x: solid.x, y: paddle_slice_y, x2: solid.x + solid.w, y2: paddle_slice_y})
        next unless paddle_line_affected_by_explosion
        puts "line affected by explosion"
      end
    end
  end

  def y
    return @solids[0].y
  end

  def top_y
    last_solid = @solids[@solids.length - 1]
    return last_solid.y + last_solid.h
  end

  def x
    return @solids[0].x
  end

  def right_x
    first_solid = @solids[0]
    return first_solid.x + first_solid.w
  end

  def solids
    return @solids
  end

  # Calculation methods

  def calculate(args)

  end
end
