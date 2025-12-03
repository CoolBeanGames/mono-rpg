##written by Dustin Booher
##creation date 12/3/25
##last edited   12/3/25
extends Node

var conversations : Dictionary = {}
var language_string : String = "en"
var dialog_display_path : String = "res://base/dialog_system/UI/dialog_display.tscn"
var dialog_display_ref : dialog_display

const DEFAULT_DICT : Dictionary = {}
const END_OF_CONVO_DICT : Dictionary = {"END_OF_CONVO" : "END_OF_CONVO"}
const NO_SPEAKER = "NO_SPEAKER"
const END_OF_CONVO_STR = "END_OF_CONVO"
const ENGLISH = "en"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_dialog()
	await get_tree().process_frame
	start_dialog("test_conversation")
	await get_tree().create_timer(5).timeout
	unload_dialog_display()


##called to load in all the dialogs
func load_dialog():
	##AI CODE BEGIN
	var file := FileAccess.open("res://data/dialog.json", FileAccess.READ)

	if file == null:
		push_error("Failed to open dialog.json")
		return

	var text := file.get_as_text()

	var result = JSON.parse_string(text)
	if result == null:
		push_error("JSON parse failed!")
		return

	conversations = result
	##AI CODE END
	
	print("loaded " , conversations.size(), " conversation(s)")


##returns a single conversation in the current language
func get_conversation(key : String) -> Dictionary:
	if !conversations.has(key):
		push_warning("could not get conversaion " , key, " as it does not exist, perhaps a typo?")
		return DEFAULT_DICT
	if !conversations[key].has(language_string):
		push_warning("could not get conversation ", key ," in given language '",language_string,"' defaulting to english")
		if !conversations[key].has(ENGLISH):
			push_warning("could not return conversation ", key ," at all as it does not support english")
			return DEFAULT_DICT
		return conversations[key][ENGLISH]
	return conversations[key][language_string]

##get a specific line from a conversation
func get_line(index : int, conversation : Dictionary) -> Dictionary:
	if !conversation.has(str(index)):
		push_warning("conversation does no have ", str(index), "returning end of conversation")
		return END_OF_CONVO_DICT
	return conversation[str(index)]

##returns the speaker for the current line
func get_speaker(line : Dictionary) -> String:
	if !line.has("speaker"):
		push_warning("could not return speaker, provided line has no speaker")
		return NO_SPEAKER
	return line["speaker"]

##gets the actual dialog for the current line
func get_conversation_line(line : Dictionary) -> String:
	if !line.has("line"):
		push_warning("could no get line, as the current dialog line does no have one, returning EOC")
		return END_OF_CONVO_STR
	return line["line"]

##attempt to load the dialog display scene
func load_dialog_display():
	var loaded_scene = SCENES.load_ui_scene("dialog_display",dialog_display_path)
	if loaded_scene!=null:
		if loaded_scene is dialog_display:
			dialog_display_ref = loaded_scene
			return dialog_display_ref
		else:
			push_warning("dialog manager loaded dialog scene, but it did not return as a dialog display")
			return null
	else:
		push_warning("dialog manager failed to load dialog display scene")
		return null

##attempt to unload a dialog display instance
func unload_dialog_display():
	if dialog_display_ref == null:
		push_warning("attempted to unload dialog display but it appears to not have been loaded in the first place")
		return
	if !SCENES.loaded_ui_scenes.has("dialog_display"):
		push_warning("attempted to unload dialog display, but it was never loaded")
		dialog_display_ref = null
		return
	SCENES.unload_ui_scene("dialog_display")
	dialog_display_ref = null

##start an instance for a dialog
func start_dialog(_dialog_key : String):
	if dialog_display_ref != null:
		push_warning("attempted to start a dialog but one appears to already be running")
		return
	var convo = get_conversation(_dialog_key)
	if convo == DEFAULT_DICT:
		push_warning("failed to load conversation, key does not exist")
		return null
	load_dialog_display()
	if dialog_display_ref:
		dialog_display_ref.start_dialog(convo)
