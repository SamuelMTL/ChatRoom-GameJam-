@tool
extends HBoxContainer
class_name OtherMessageContainer

@onready var message_list_node: VBoxContainer = self.find_child("MessageList")
@onready var profile_picture_node: TextureRect = self.find_child("IconImageTexture")
@onready var other_message_node = preload("res://components/UI/OtherMessage.tscn")

@export
var profile_picture: Texture:
	set(val):
		profile_picture = val
		if (profile_picture_node != null):
			profile_picture_node.texture = val
		

@export_multiline
var messages: Array[String] = []:
	set(val):
		messages = val
		_render_messages(val)

func config(picture: Texture, messages: Array[String]):
	profile_picture = picture
	self.messages = messages

func _render_messages(messages: Array[String]):
	if (message_list_node == null):
		return
	
	for child in message_list_node.get_children():
		child.queue_free()

	for message in messages:
		var message_node = other_message_node.instantiate() as Label
		message_node.text = message

		message_list_node.add_child(message_node)
