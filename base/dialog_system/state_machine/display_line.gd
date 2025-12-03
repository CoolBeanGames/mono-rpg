##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25

class_name dialog_state_display_line
extends dialog_state

var time_per_character : float = 0.01
var total_time : float = 0

func on_enter():
	display.text.visible_ratio = 0
	total_time = time_per_character * display.text.get_total_character_count()
	var t : Tween = create_tween()
	t.tween_property(display.text,"visible_ratio",1,total_time)
	t.finished.connect(tween_finished)

func tween_finished():
	display.change_state("await_user_input")

func on_exit():
	pass

func on_process():
	pass

func on_confirm():
	display.change_state("await_user_input")
	pass
