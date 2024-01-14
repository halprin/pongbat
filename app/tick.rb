def tick(args)

  initialize(args) if args.state.tick_count.zero?

  args.state.scene.tick(args)
end

def initialize(args)
  # args.state.scene = MainGameScene.new('/data/level1.json', args)
  args.state.scene = MainMenuScene.new(args)
end
