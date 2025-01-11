@tool
class_name MyMessage extends HBoxContainer


@onready var message_item: Label = find_child("MessageItem")


@export_multiline
var message: String:
	set(val):
		message = val
		if (message_item != null):
			message_item.text = val

func config(message: String):
	self.message = message
