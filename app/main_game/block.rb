class Block < Sprite

  @@width = 40
  @@height = 40

  def initialize(args, block_image, starting_x, starting_y)
    super(args, '/sprites/block/' + block_image, starting_x, starting_y, @@width, @@height)
  end

  # Action methods

  def apply_difference(ball)
    # no default implementation
  end

  # Calculation methods
end
