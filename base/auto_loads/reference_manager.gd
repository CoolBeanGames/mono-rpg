##written by Dustin Booher
##creation date 12/1/25
##last edited   12/1/25
class_name reference_manager extends Node

##the database where all references is store.
var references : Dictionary[String,Node] = {}

##read references from the database if it exists.
func read(key : String, default : Variant = null):
	return references.get(key,default) 

##writes new references to the database.
func write(key : String, input_reference : Variant = null, overwrite : bool = true):
	if references.has(key):
		if overwrite:
			references[key] = input_reference
		else:
			push_warning("attempted to write data to public store, but data is already set and is not overwritable. Key: ", key)
	else:
		references[key] = input_reference

##returns wether or not the references exists in the database or not.
func exists(key : String) -> bool:
	return references.has(key)

##erase data from the database
func erase(key : String):
	if !exists(key):
		push_warning("attempted to erase a non-existant reference, Key: ",key)
	else:
		references.erase(key)
