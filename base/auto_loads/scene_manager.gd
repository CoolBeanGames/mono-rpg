##written by Dustin Booher
##creation date 12/1/25
##last edited   12/1/25
class_name scene_manager extends Node

##the main scene that is currently loaded
var loaded_scene : Node
##all of the UI scenes that are currently loaded
var loaded_ui_scenes : Dictionary[String,Node] = {}
##all loaded scenes get added to this base
var scene_root : Node

func initialize(root : Node):
	scene_root = root

func scene_load(scene_path : String, allow_override : bool = false):
	if scene_root == null:
		push_error("Error! scene root not set in scene manager, cannot load scene")
		return
	if allow_override or loaded_scene == null:
		#load the scene
		var scn : PackedScene = load(scene_path)
		#if a scene is already loaded unload it
		if loaded_scene!=null:
			print("cleared loaded scene")
			loaded_scene.queue_free()
		#load our instance as an instance and set it up
		var instance = scn.instantiate()
		instance.reparent(scene_root)
		#loading should be complete
	else:
		push_warning("Attempted to load a scene but one is already set and is not overridable Path: ", scene_path)

##load a new ui scene to the screen
func load_ui_scene(ui_name : String, ui_path : String ):
	#various error checks
	if scene_root == null:
		push_error("Error 0e1 : scene root not set in scene manager, cannot load scene")
		return

	if loaded_ui_scenes.has(ui_name):
		push_error("ERROR 0e2 : Could not load UI, scene already exists!")
		return
	
	var scn : PackedScene = load(ui_path)
	if scn == null:
		push_error("ERROR 0e3 : failed to load ui scene from path"  )
		return
	
	#assign the data
	var instance : Node = scn.instantiate()
	instance.reparent(scene_root)
	loaded_ui_scenes[ui_name] = instance

##unload a ui scene if it is already loaded
func unload_ui_scene(ui_name : String):
	if loaded_ui_scenes.has(ui_name):
		if loaded_ui_scenes[ui_name] != null:
			loaded_ui_scenes[ui_name].queue_free()
		loaded_ui_scenes.erase(ui_name)
	else:
		push_warning("Attempted to unload a ui scene but it is not currently loaded")
