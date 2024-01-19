class Explosion < Sprite
  attr_accessor :radius

  @@expansion_velocity = 2
  @@collapse_velocity = 10

  def initialize(args, x, y, explosions)
    super(args, '/sprites/explosion.png', x, y, 0, 0)

    @radius = 0
    @max_radius = rand(390) + 1 + 10  # random radius between 10 an 400
    @start_x = x
    @start_y = y
    @expanding = true
    @explosions = explosions
  end

  def calculate(args)
    if !@expanding && @radius <= 0
      @explosions.delete(object_id)
    end

    if @expanding
      @radius += @@expansion_velocity
    else
      @radius -= @@collapse_velocity
    end

    change_radius(@radius)

    if @radius >= @max_radius
      @expanding = false
    end

  end

  def change_radius(radius)
    @x = @start_x - radius
    @y = @start_y - radius
    @w = radius * 2
    @h = radius * 2
  end

end
