class Paddle < Sprite

  @@speed = 4
  @@width = 20
  @@height = 200

  def initialize(args, paddle_image, starting_x, starting_y)
    super(args, '/sprites/paddle/' + paddle_image, starting_x, starting_y, @@width, @@height)

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

  # Calculation methods

  def calculate(args)

  end
end
