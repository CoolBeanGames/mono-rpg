##written by Dustin Booher
##creation date 12/1/25
##last edited   12/1/25
class_name game_manager extends Node

#the root scene for instantiating new scenes
@export var scene_root : Node 
@export var audio_stack : stack
@export var current_state : game_state

#references to all the states
@export var states : Dictionary[String,game_state] = {}

##initialize the game manager (state machine)
func _ready() -> void:
	SCENES.initialize(scene_root)
	REFS.write("scene_root",scene_root)
	AUDIO.setup(audio_stack)
	
	if states.size() == 0:
		push_error("ERROR 0e4 : No game states defined in game manager")
	
	for s in states.values():
		s.setup(self)
	switch_state("preload")

func _process(_delta: float) -> void:
	if current_state!=null:
		current_state.on_process()

##attempt to swap the current state we are in
func switch_state(state_key : String):
	if !states.has(state_key):
		push_error("ERROR 0e05 : attempted to enter state ", state_key , " but state does not exist in game manager -> states")
		return
	if current_state == null:
		current_state = states[state_key]
		current_state.on_enter()
	else:
		current_state.on_exit()
		current_state = states[state_key]
		current_state.on_enter()
