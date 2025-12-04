##written by Dustin Booher
##creation date 12/3/25
##last edited   12/4/25
class_name dialog_state_display_line
extends dialog_state

##how long to spend per character
var time_per_character : float = 0.01
##total ammount of time for this line to be getting displayed
var total_time : float = 0
##used to decide when to play a pip sound
@export var pip_sound_timer : Timer
@export var pip_wait_sound : float = 0.15
##the tween that runs the text crawl
var t : Tween

##set up the pips for the text crawl (via a tween)
func on_enter():
	pip_sound_timer.wait_time = pip_wait_sound
	pip_sound_timer.start()
	display.text.visible_ratio = 0
	total_time = time_per_character * display.text.get_total_character_count()
	t = create_tween()
	t.tween_property(display.text,"visible_ratio",1,total_time)
	t.finished.connect(tween_finished)

##called when the tween is finished
func tween_finished():
	display.change_state("await_user_input")

func on_exit():
	pip_sound_timer.stop()

#region Unused

func on_process():
	pass
#endregion

##skip the text crawl
func on_confirm():
	pip_sound_timer.stop()
	if t.is_running():
		t.stop()
	display.text.visible_ratio = 1
	AUDIO.play_audio(display.ui_confirm_sound,0.5)
	display.change_state("await_user_input")
	pass

##play audio pip sound
func play_pip_sound():
	print("play")
	AUDIO.play_audio(display.ui_dialog_pip,0.5)
	pip_sound_timer.wait_time = pip_wait_sound + randf_range(0,0.025)
	pip_sound_timer.start()
