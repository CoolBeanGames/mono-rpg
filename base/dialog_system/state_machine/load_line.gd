##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25

class_name dialog_state_load_line
extends dialog_state

func on_enter():
	var line = DIALOG.get_line(display.index,display.conversation)
	if line == DIALOG.END_OF_CONVO_DICT:
		push_warning("End of Dialog") ##properly close out here
		return
	var dlg = DIALOG.get_conversation_line(line)
	if dlg == DIALOG.END_OF_CONVO_STR:
		push_warning("end of dialog") ##properly close out here as well
	display.set_text(DIALOG.get_speaker(line),dlg)
	display.index+=1

func on_exit():
	pass

func on_process():
	pass

func on_confirm():
	pass
