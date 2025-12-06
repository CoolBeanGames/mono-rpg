##written by Dustin Booher
##creation date 12/6/25
##last edited   12/6/25
class_name interaction_action_dispatcher
extends Node2D

@export var sets : Dictionary[condition,action_set] = {}

func _on_interactable_on_interact() -> void:
	for s in sets:
		if s.evaluate():
			for a in sets[s].actions:
				if a.enabled == true:
					sets[s].execute()
					return
