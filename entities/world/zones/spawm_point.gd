##written by Dustin Booher
##creation date 12/2/25
##last edited   12/2/25
extends Node2D

@export var key : String
@export var player_reference : CharacterBody2D


# Called when the node enters the scene tree for the first time.$"."
func _ready() -> void:
	if DATA.exists("last_teleport_tag") and DATA.read("last_teleport_tag") == key:
		player_reference.position = position
		DATA.remove(key)
		queue_free()
	else:
		queue_free()
	pass # Replace with function body.
