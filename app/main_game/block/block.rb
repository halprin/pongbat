class Block < Sprite

  @@width = 40
  @@height = 40

  def initialize(args, block_image, starting_x, starting_y, blocks)
    super(args, '/sprites/block/' + block_image, starting_x, starting_y, @@width, @@height)
    @creation_frame = args.state.tick_count
    @duration_of_existence_frames = (rand(20) + 1 + 5) * 60  # random between 5 - 20 seconds
    @blocks = blocks
  end

  # Action methods

  def apply_difference(ball)
    # no default implementation
  end

  # Calculation methods

  def calculate(args)
    if @creation_frame.elapsed_time >= @duration_of_existence_frames
      @blocks.delete(object_id)
    end
  end
end
