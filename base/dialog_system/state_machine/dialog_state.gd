##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25

@abstract
class_name dialog_state
extends Node

var display : dialog_display

func setup(manager : dialog_display):
	display = manager

@abstract func on_enter()
@abstract func on_exit()
@abstract func on_process()
@abstract func on_confirm()
