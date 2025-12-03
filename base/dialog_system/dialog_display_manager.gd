##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25
class_name dialog_display
extends Node

##a referemce to the speaker
@export var speaker : Label
##a reference to the dialog display
@export var text : RichTextLabel
##a conversation that is loaded in
@export var conversation : Dictionary
@export var index : int = 0

##state machine stuff
var current_state : dialog_state
@export var states : Dictionary[String,dialog_state]

##called to set the text of the dialog
func set_text(spkr : String, dlg : String):
	if spkr == DIALOG.NO_SPEAKER:
		speaker.text = ""
	text.text = dlg

##actually start the ball rolling on the dialog
func start_dialog(convo : Dictionary):
	conversation = convo
	setup_state_machine()

##drive the current states process
func _process(_delta: float) -> void:
	if current_state:
		current_state.on_process()
		if Input.is_action_just_released("confirm"):
			current_state.on_confirm()

##make sure all states have the data that they need
func setup_state_machine():
	for s in states.values():
		s.setup(self)
	current_state = states["load_line"]
	current_state.on_enter()
