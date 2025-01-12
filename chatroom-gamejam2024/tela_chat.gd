extends Control
@export_file("*.json") var json_file1: String = ""
@export_file("*.json") var json_file2: String = ""
@export_file("*.json") var json_file3: String = ""
@export_file("*.json") var json_file4: String = ""

@onready var messages_list_node: VBoxContainer = find_child("MessagesList", true)
@onready var options_list_node: OptionsContainer = find_child("OptionsContainer", true)
@onready var other_message_container = preload("res://components/UI/OtherMessageContainer.tscn")
@onready var my_message_container_component = preload("res://components/UI/MyMessage.tscn")
@onready var scroll_container: ScrollContainer = find_child("MessagesScrollContainer", true)

var message_stack: Array[Dictionary] = []

func _ready():
	scroll_container.get_v_scroll_bar().changed.connect(self._scroll_changed)
	options_list_node.option_chosen.connect(self._on_option_chosen)

	await _show_json_dialogue(json_file1)
	
	var options: Array[String] = [
		"Perguntar sobre o jogo",
		"Se apresentar",
	]

	_show_options(options)

func _show_options(options: Array[String]):

	options_list_node.options = options
	options_list_node.visible = true

func _show_json_dialogue(json_path: String):
	var json = JSON.new()
	var error = json.parse(FileAccess.get_file_as_string(json_path))
	var data = json.data
	
		
	await _append_dialogue(data)


func _scroll_changed():
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value

func _append_dialogue(data: Array[Variant]):
	for message in data:

		message_stack.append(message)
		var sender: String = message['sender']
		var content: String = message['text']
		await get_tree().create_timer(len(content) / 40).timeout
		print(scroll_container.scroll_vertical)
		if (sender == "Max"):
			var message_node: MyMessage = my_message_container_component.instantiate()
			messages_list_node.add_child(message_node)
			message_node.config(content)
			message_node.grab_focus()
		else:
			var last_message = _get_last_message()

			var last_sender = last_message['sender'] if last_message != null else null
			
		
			if (last_sender == sender):
				var children = messages_list_node.get_children()
				var curr_index = len(children) - 1
				var message_node: OtherMessageContainer = children[curr_index]
				var new_array = message_node.messages
				new_array.append(content)
				
				message_node.messages = new_array
			else:
				var message_node: OtherMessageContainer = other_message_container.instantiate()
				messages_list_node.add_child(message_node)
				message_node.config(PlaceholderTexture2D.new(), [content])
				message_node.grab_focus()

	
		var scroll_bar = scroll_container.get_v_scroll_bar()
		scroll_bar.value = scroll_bar.max_value

		await get_tree().create_timer(len(content) / 30 + 1).timeout

func _get_last_message():
	var curr_index = len(message_stack) - 1

	if (curr_index <= 0):
		return null

	return message_stack[curr_index - 1]
		

func _on_option_chosen(option: OptionItem):
	var index = option.index
	
	match (index):
		0:
			await _show_json_dialogue(json_file2)
		1:
			await _show_json_dialogue(json_file3)
			
	await _show_json_dialogue(json_file4)
