##written by Dustin Booher
##creation date 12/6/25
##last edited   12/6/25
class_name action_set
extends Resource

##all of the actions in the set
@export var actions : Array[action] = []

##once called execute every action in the set
func execute():
	for a in actions:
		a.execute()
