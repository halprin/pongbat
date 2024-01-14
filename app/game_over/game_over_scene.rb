class GameOverScene < Scene
  def initialize(args)
    super('game_over', args)
  end

  def tick(args)
    # black background
    @args.outputs.background_color = [0, 0, 0]

    label_text = 'Game Over'
    label_size = 10

    _, label_height = args.gtk.calcstringbox(label_text, label_size)
    @args.outputs.labels << [@args.grid.w / 2, @args.grid.h / 2 + label_height / 2, label_text, label_size, 1, 255, 255, 255]
  end
end
