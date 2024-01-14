class MainMenuScene < Scene
  def initialize(args)
    super('main_menu', args)

    start_game = proc do
      @args.state.scene = MainGameScene.new(@args)
    end
    @start_game_button = Button.new(100, 100, 300, 100, [255, 255, 255], 'Play', 5, [0, 0, 0], start_game)
  end

  def tick(args)
    # black background
    @args.outputs.background_color = [0, 0, 0]

    @args.outputs.labels << [@args.grid.w / 2, @args.grid.top - @args.grid.h / 4, 'Pongbat!', 10, 1, 255, 255, 255]

    @start_game_button.render_and_calculate(args)
  end
end
