##written by Dustin Booher
##creation date 12/5/25
##last edited   12/5/25
class_name flag_manager
extends Node

var flags : Array[String] = []
var flag_watchers : Dictionary[String,Dictionary] = {}
var flag_on_watchers : Dictionary[String,Dictionary] = {}
var flag_off_watchers : Dictionary[String,Dictionary] = {}
var flag_once_watchers : Dictionary[String,Dictionary] = {}

##add and set a flag
func set_flag(flag : String):
	if flags.has(flag):
		push_warning("flag, ", flag, " is already set, cannot set again")
		return
	flags.append(flag)
	if flag_watchers.has(flag):
		call_watcher(flag_watchers,flag)
	if flag_on_watchers.has(flag):
		call_watcher(flag_on_watchers,flag)
	if flag_once_watchers.has(flag):
		call_watcher(flag_once_watchers,flag)
		flag_once_watchers.erase(flag)

##remove and unset a flag
func unset_flag(flag : String):
	if !flags.has(flag):
		push_warning("attempted to unset flag " , flag , " but it was bever set in the first place")
		return
	flags.erase(flag)
	if flag_watchers.has(flag):
		call_watcher(flag_watchers,flag)
	if flag_off_watchers.has(flag):
		call_watcher(flag_off_watchers,flag)
	if flag_once_watchers.has(flag):
		call_watcher(flag_once_watchers,flag)
		flag_once_watchers.erase(flag)

##script to call all the callables that have been subscribed to
func call_watcher(watchers : Dictionary , flag : String):
	for f in watchers[flag].values():
		f.call()

##general purpose function to register a watcher
func register_watcher_to_list(list : Dictionary[String,Dictionary],flag : String, call_method : Callable, caller : String):
	if list.has(flag):
		if list[flag].has(caller):
			push_warning("watcher, ", caller, " allready registered to, ", flag)
			return
		list[flag][caller] = call_method
		return
	list[flag] = {}
	list[flag][caller] = call_method

func add_watcher(flag : String, watcher : String, call_method : Callable):
	register_watcher_to_list(flag_watchers,flag,call_method,watcher)

func add_on_watcher(flag : String, watcher : String, call_method : Callable):
	register_watcher_to_list(flag_on_watchers,flag,call_method,watcher)

func add_off_watcher(flag : String, watcher : String, call_method : Callable):
	register_watcher_to_list(flag_off_watchers,flag,call_method,watcher)

func add_once_watcher(flag : String, watcher : String, call_method : Callable):
	register_watcher_to_list(flag_once_watchers,flag,call_method,watcher)

func has_flag(flag : String) -> bool:
	return flags.has(flag)
