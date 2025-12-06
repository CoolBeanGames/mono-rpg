##written by Dustin Booher
##creation date 12/6/25
##last edited   12/6/25
class_name condition_flag_status
extends condition

enum CHECK{is_set,is_not_set}
@export var flag : String
@export var check_for : CHECK

func evaluate(_param_1=null,_param_2=null) -> bool:
	match(check_for):
		CHECK.is_set:
			return FLAGS.has_flag(flag)
		CHECK.is_not_set:
			return !FLAGS.has_flag(flag)
	return false
