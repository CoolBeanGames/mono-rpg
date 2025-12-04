##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25
class_name input_manager
extends Node


signal on_confirm
signal on_cancel

var input_blockers : Dictionary = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("confirm"):
		on_confirm.emit()
	if Input.is_action_just_released("cancel"):
		on_cancel.emit()

##checks to see if the input is blocked
func is_input_blocked() -> bool :
	return input_blockers.size() > 0

##adds a new input blocker
func block_input(blocker_name : String, blocker):
	if input_blockers.has(blocker_name):
		push_warning("attempted to block input with ", blocker_name, " but that blocker already exists")
		return
	input_blockers.set(blocker_name,blocker)

##unblocks input
func release_block(blocker_name : String):
	if !input_blockers.has(blocker_name):
		push_warning("attempted to unblock input but blocker" , blocker_name , " does not exist ")
		return
	input_blockers.erase(blocker_name)

##removes all input blocks
func release_all_blocks():
	input_blockers.clear()
