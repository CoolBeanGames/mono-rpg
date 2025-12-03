##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25
class_name interactable
extends Area2D

##fired off when the player interacts with this object
signal on_interact

##a simple flag for when the player is within the area
@export var player_in_area : bool

##checks if the player is in area and if you have pressed confirm, if both are yes
##fires off signal
func _process(_delta: float) -> void:
	if !player_in_area:
		return
	if Input.is_action_just_released("confirm"):
		on_interact.emit()

##sets player in area to true when the player enters the area
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true

##sets playef in area to false when the player exits the area
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
