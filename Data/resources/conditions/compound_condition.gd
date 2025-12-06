##written by Dustin Booher
##creation date 12/6/25
##last edited   12/6/25
class_name compound_condition
extends condition

enum CHECK{is_set,is_not_set}
@export var conditions : Array[condition] = []

func evaluate(_param_1 = null,_param_2 = null) -> bool:
	for c in conditions:
		if c.evaluate(_param_1,_param_2) == false:
			return false
	return true
