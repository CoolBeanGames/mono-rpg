##written by Dustin Booher
##creation date 12/2/25
##last edited   12/2/25
extends Node

##the character body we are moving
@export var body : CharacterBody2D
##the speed the character should move at
@export var move_speed : float = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	move(get_axis())

##create an input vector from input values
func get_axis() -> Vector2:
	return Input.get_vector("left","right","up","down")

##move the character
func move(axis : Vector2):
	var velocity : Vector2 = axis * move_speed
	body.velocity = velocity
	body.move_and_slide()
