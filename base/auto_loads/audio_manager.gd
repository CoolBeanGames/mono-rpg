##written by Dustin Booher
##creation date 12/4/25
##last edited   12/4/25
class_name audio_manager
extends Node

@export var stack_source : stack
@export var playing_audio : Array = []
@export var player_scene : PackedScene

##setup the stack
func setup(root : stack):
	stack_source = root
	player_scene = load("res://entities/systems/audio_player.tscn")
	stack_source.added_to_stack.connect(returned_to_stack)

##called when swapping scenes to kill all of the audio playing
func kill_all_audio():
	while playing_audio.size() > 0:
		var a = playing_audio[0]
		a.kill()
		playing_audio.remove_at(0)

##call to play audio
func play_audio(clip : AudioStream, linear_volume : float) -> audio_player:
	var player : audio_player = stack_source.pop(player_scene)
	if !player:
		push_warning("could not initialize audio player")
		return null
	player.start(clip,stack_source,linear_volume)
	playing_audio.append(player)
	return player

##called when the stack returns something, removes it from the list
func returned_to_stack(object):
	if playing_audio.has(object):
		playing_audio.erase(object)
