##written by Dustin Booher
##creation date 12/2/25
##last edited   12/2/25
extends Area2D

@export var spawn_point_key : String
@export var spawm_direction : String = "North"
@export var scene_path : String

# Called when the node enters the scene tree for the first time.
##mostly used for checking that all of the data is valid
func _ready() -> void:
	if spawn_point_key == "" or spawn_point_key == null:
		push_error("Teleport zone ", name, " is invalid as it has no spawn point zone set...")
		queue_free()
	
	if scene_path == "" or scene_path == null:
		push_error("Teleport zone ", name, " is invalid as it has no scene path set...")
		queue_free()


##when the player enterers the teleport zone write the tag for player spawn location and 
##load the scene
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		DATA.write("last_teleport_tag",spawn_point_key,true)
		DATA.write("spawn_direction",spawm_direction)
		SCENES.scene_load(scene_path,true)
