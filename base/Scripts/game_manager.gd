##written by Dustin Booher
##creation date 12/1/25
##last edited   12/1/25
class_name game_manager extends Node

#the root scene for instantiating new scenes
@export var scene_root : Node 

func _ready() -> void:
	SCENES.initialize(scene_root)
	REFS.write("scene_root",scene_root)
