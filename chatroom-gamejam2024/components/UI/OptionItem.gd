@tool
class_name OptionItem extends Button

@export
var content: String:
	set(val):
		content = val
		text = val
