# $gtk.reset seed: 26

require '/app/scene.rb'
require '/app/sprite.rb'
require '/app/button.rb'

# main menu scene
require '/app/main_menu/main_menu_scene.rb'

# main game scene
require '/app/main_game/main_game_scene.rb'
require '/app/main_game/paddle.rb'

require '/app/main_game/ball/ball.rb'
require '/app/main_game/ball/red_ball.rb'
require '/app/main_game/ball/blue_ball.rb'
require '/app/main_game/ball/unclaimed_ball.rb'
require '/app/main_game/ball/drunk_ball.rb'
require '/app/main_game/ball/bomb_ball.rb'

require '/app/main_game/block/block.rb'
require '/app/main_game/block/speed_up_block.rb'
require '/app/main_game/block/speed_down_block.rb'
require '/app/main_game/block/extra_ball_block.rb'
require '/app/main_game/block/remove_ball_block.rb'
require '/app/main_game/block/drunk_ball_block.rb'

# game over scene
require '/app/game_over/game_over_scene.rb'

# final tick
require '/app/tick.rb'
