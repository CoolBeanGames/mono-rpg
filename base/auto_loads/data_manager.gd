##written by Dustin Booher
##creation date 12/1/25
##last edited   12/2/25
class_name data_manager extends Node

##the database where all data is store.
var data : Dictionary = {}

##read data from the database if it exists.
func read(key : String, default : Variant = null):
	return data.get(key,default) 

##writes new data to the database.
func write(key : String, input_data : Variant = null, overwrite : bool = true):
	if data.has(key):
		if overwrite:
			data[key] = input_data
		else:
			push_warning("attempted to write data to public store, but data is already set and is not overwritable. Key: ", key)
	else:
		data[key] = input_data

##returns wether or not the data exists in the database or not.
func exists(key : String) -> bool:
	return data.has(key)

##removes data if it exists
func remove(key : String):
	if exists(key):
		data.erase(key)
