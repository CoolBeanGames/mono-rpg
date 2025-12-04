##written by Dustin Booher
##creation date 12/4/25
##last edited   12/4/25
class_name audio_player
extends AudioStreamPlayer2D

##the stack to return to when finished
var source_stack : stack
##emits when this player is done playing
signal audio_finished

##setup and play audio
func start(clip : AudioStream, audio_stack , linear_volume : float = 0.5):
	if get_parent() != null:
		reparent(REFS.read("scene_root",source_stack))
	else:
		REFS.read("scene_root",source_stack).add_child(self)
	stream = clip
	volume_db = linear_to_db(linear_volume)
	source_stack = audio_stack
	play(0)

##called when the audio finishes, returns the player to the stack
func _on_finished() -> void:
	audio_finished.emit()
	source_stack.push(self)

##called when changing scenes to end all audio
func kill():
	stop()
	source_stack.push(self)
