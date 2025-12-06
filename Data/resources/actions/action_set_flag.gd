##written by Dustin Booher
##creation date 12/6/25
##last edited   12/6/25
class_name action_set_flag
extends action

##the flag to be set to true when this action is executed
@export var flag : String

##set the flag
func execute(_arg_1 = null , _arg_2 = null, _arg_3 = null):
	FLAGS.set_flag(flag)
