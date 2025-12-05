##written by Dustin Booher
##creation date 12/5/25
##last edited   12/5/25

class_name action_flag_pair
extends Resource

@export var flag : String = ""
@export var act : action = null
@export var execute_on_flag : bool = false
@export var disable_on_execute : bool = false
var enabled : bool = true

##must be called before this is operational
func setup():
	if execute_on_flag:
		###todo: connect flag signal here
		pass
	pass

##when the required flag is set, execute the action
func on_flag():
	execute()

##called to actually execute
func execute():
	if enabled:
		act.execute()
		if disable_on_execute:
			enabled = false
	else:
		###todo disconnect from the flag
		pass
