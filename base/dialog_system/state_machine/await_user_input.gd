##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25

class_name dialog_state_await_user_input
extends dialog_state

#region Unused
func on_enter():
	pass

func on_exit():
	pass

func on_process():
	pass
#endregion

##when the user pressed confirm load the next line (or finish)
func on_confirm():
	AUDIO.play_audio(display.ui_confirm_sound,0.5)
	display.change_state("load_line")
