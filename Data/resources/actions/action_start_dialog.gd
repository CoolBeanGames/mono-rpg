##written by Dustin Booher
##creation date 12/6/25
##last edited   12/6/25
class_name action_start_dialog
extends action

##the dialog to start when this action is executed
@export var dialog_key : String

##start the dialog
func execute(_arg_1 = null , _arg_2 = null, _arg_3 = null):
	DIALOG.start_dialog(dialog_key)
