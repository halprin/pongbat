class Sprite
  attr_sprite

  def initialize(args, image_path, x, y, width, height)
    @args = args
    @path = image_path
    @x = x
    @y = y
    @w = width
    @h = height
  end

  def calculate(args)
    # do nothing by default
  end

  # Returns which side of this sprite that other_sprite is
  def collision_side(other_sprite)

    angle = @args.geometry.angle_to(center(), other_sprite.center())

    if angle > 45 && angle < 135
      return :top
    elsif angle >= 135 && angle <= 225
      return :left
    elsif angle > 225 && angle <= 315
      return :bottom
    else
      return :right
    end
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
end
