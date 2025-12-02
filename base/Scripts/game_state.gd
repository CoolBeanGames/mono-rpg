##written by Dustin Booher
##creation date 12/1/25
##last edited   12/1/25
@abstract class_name game_state extends Node

##a reference to the game manager
var manager : game_manager

##call when setting up state
func setup(_parent : game_manager):
	manager = _parent

##abstract functions
@abstract func on_enter()
@abstract func on_exit()
@abstract func on_process()
