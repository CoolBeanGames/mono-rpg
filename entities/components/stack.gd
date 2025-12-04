##written by Dustin Booher
##creation date 12/4/25
##last edited   12/4/25
class_name stack
extends Node

##all of the nodes stored here
@export var stored : Array = []
signal added_to_stack(object)
signal pulled_from_stack(object)
signal new_object_created(object)

##pull a scene from the stack
func pop(scene : PackedScene = null) -> Variant:
	if stored.size() > 0:
		var obj = stored[0]
		stored.remove_at(0)
		pulled_from_stack.emit(obj)
		return obj
	if scene == null:
		return null
	pulled_from_stack.emit(scene)
	return instantiate(scene)

##push a new scene onto the stack
func push(object : Variant):
	added_to_stack.emit(object)
	stored.append(object)
	object.reparent(self)

##create a new instance of whatever scene is passed to it
func instantiate(scene : PackedScene) -> Variant:
	var instance = scene.instantiate()
	new_object_created.emit(scene)
	return instance
