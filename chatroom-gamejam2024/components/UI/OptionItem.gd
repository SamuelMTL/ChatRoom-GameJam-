@tool
class_name OptionItem extends Button

@export
var index: int:
	set(val):
		index = val
		update_info()

@export
var content: String:
	set(val):
		content = val
		update_info()
		

func update_info():
	text = "%d. %s" % [index + 1, content]
