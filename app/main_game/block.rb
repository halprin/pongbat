class Block < Sprite

  @@width = 40
  @@height = 40

  def initialize(args, block_image, starting_x, starting_y, remove_block_function)
    super(args, '/sprites/block/' + block_image, starting_x, starting_y, @@width, @@height)
    @creation_frame = args.state.tick_count
    @duration_of_existence_frames = (rand(20) + 1 + 5) * 60  # random between 5 - 20 seconds
    @remove_block_function = remove_block_function
  end

  # Action methods

  def apply_difference(ball)
    # no default implementation
  end

  # Calculation methods

  def calculate(args)
    if @creation_frame.elapsed_time >= @duration_of_existence_frames
      @remove_block_function.call
    end
  end
end
